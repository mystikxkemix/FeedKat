<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get all cats
$app->get('/cat', function() use ($app) {
    $cats = $app['db']->fetchAll('select c.*, group_concat(distinct d.id_dispenser) id_dispenser, u.id_user from cat c left join cat_dispenser cd using(id_cat) left join dispenser d using(id_dispenser) join user u using(id_user)');
	$cats[0]['id_dispenser'] = explode(',', $cats[0]['id_dispenser']);
	return $app->json($cats);
});

$app->put('/cat', function (Request $request) use ($app) {

	$data_cat = array('name','birth','photo');
	
	$ins_col = array();
	foreach($data_cat as $col)
		if($request->request->get($col) != '')	
			$ins_col[$col] = '\''.$request->request->get($col).'\'';
	
	$ins_sql = "insert into cat ";
	$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
	$ins_sql .= " values (";
	$ins_sql .= implode(', ',$ins_col).')';
	
	$r = $app['db']->query($ins_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    //$post = array(
    //    'error' => $error,
    //    'id_cat'  => $app['db']->lastInsertId()
    //);
	$post['error'] = $error;
	$post['id_cat'] = $app['db']->lastInsertId();
	
	if($request->request->get('id_user') != '') {
		$ins_cu = 'insert into cat_user (id_cat,id_user) values ('.$post['id_cat'].','.$request->request->get('id_user').')';
		$app['db']->query($ins_cu);
	}
	
	if($error == 0) {
		// link with a collar
		if($request->request->get('id_collar') != '') {
			$upd_col = "update collar set 
				id_cat = ".$request->request->get('id_cat')." 
				AND mac = ".$request->request->get('mac')." 
				WHERE id_collar = ".$request->request->get('id_collar')."";
			$app['db']->query($upd_col);
		}
	}
	
	
	
    //$times = $app['db']->fetchAll('select * from feed_');
	//return $app->json($times);
    return $app->json($post);
});


// API : get a specific cat
$app->get('/cat/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select 
		c.id_cat,
		c.name,
		c.birth,
		if(photo!=\'\',1,0) photo, d.id_dispenser, u.id_user, 
		group_concat(concat(f.id_feedtime,\'||\',f.id_dispenser,\'||\',f.time,\'||\',f.weight,\'||\',f.enabled)) feed_times 
		from cat c left join cat_dispenser cd using(id_cat) left join dispenser d using(id_dispenser) left join user u using(id_user) left join feed_times f using(id_cat) 
		where c.id_cat = \''.$id.'\' group by c.id_cat');
	if(count($cats) > 0) {
		$feedtimes = explode(',',$cats[0]['feed_times']);
		$cats[0]['feed_times'] = array();
		foreach($feedtimes as $k => $v) {
			$feedtime = explode('||',$v);
			$cats[0]['feed_times'][] = array('id_feedtime' => $feedtime[0], 'id_dispenser' => $feedtime[1], 'time' => $feedtime[2], 'weight' => $feedtime[3], 'enabled' => $feedtime[4]);
		}
		$cats['error'] = 0;
	}
	else {
		$cats['error'] = 1;
	}
	return $app->json($cats);
});

// API : get cats by user ID
$app->get('/cat/user/{id}', function($id) use ($app) {
	global $addr;
	$res = $app['db']->fetchAll('select id_user from user u where u.id_user = \''.$id.'\'');
	if(count($res) == 0)
	{
		$data['error'] = 1;
	}
	else
	{
		/*
		$cats = $app['db']->fetchAll('select c.id_cat, c.name, c.photo from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where u.id_user = \''.$id.'\'');
		
		$data['error'] = 0;
		$data['cats'] = $cats;
		foreach($data['cats'] as $icat => $kcat) {
			$data['cats'][$icat]['ok'] = 1;
			$data['cats'][$icat]['status'] = 'Votre chat est COOL';
		}
		*/
		
		$r = $app['db']->query('select
			c.id_cat,
			c.name,
			c.birth,
			if(photo!=\'\',concat(\'http://'.$addr.'/api/img.php?id_cat=\',c.id_cat),\'\') photo, 
			u.id_user, 
			group_concat(concat(f.id_feedtime,\'||\',f.id_dispenser,\'||\',f.time,\'||\',f.weight,\'||\',f.enabled)) feed_times 
			from cat c join cat_user cu using(id_cat) join user u using(id_user) left join feed_times f on f.id_cat = c.id_cat and f.enabled = 1
			left join dispenser d using(id_dispenser)
			where u.id_user = \''.$id.'\' 
				and c.id_cat is not null group by c.id_cat');
		
		
		
		$cats = $r->fetchAll();
		$r->closeCursor();
		$data['error'] = 0;
		$data['cats'] = $cats;
		foreach($data['cats'] as $icat => $kcat) {
			$data['cats'][$icat]['ok'] = 1;
			if($icat == 0)
				$data['cats'][$icat]['ok'] = 0;
			$data['cats'][$icat]['status'] = $data['cats'][$icat]['name'].' va bien !';
			if($icat == 0) {
				$data['cats'][$icat]['status'] = 'Attention à la nutrition d';
				if(in_array(substr($data['cats'][$icat]['name'],0,1),array('A','E','I','O','U','Y')))
					$data['cats'][$icat]['status'] .= '\'';
				else
					$data['cats'][$icat]['status'] .= 'e';
				$data['cats'][$icat]['status'] .= $data['cats'][$icat]['name'];
			}
			$feedtimes = explode(',',$data['cats'][$icat]['feed_times']);
			$data['cats'][$icat]['feed_times'] = array();
			foreach($feedtimes as $k => $v) {
				if($v != '') {
					$feedtime = explode('||',$v);
					$data['cats'][$icat]['feed_times'][] = array('id_feedtime' => $feedtime[0], 'id_dispenser' => $feedtime[1], 'time' => $feedtime[2], 'weight' => $feedtime[3], 'enabled' => $feedtime[4]);
				}
			}
			$data['cats'][$icat]['battery'] = 67;
			$data['cats'][$icat]['weight'] = 4670;
		}
	}
	
	return $app->json($data);
});

// API : get cats by dispenser ID
$app->get('/cat/dispenser/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select c.* from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where d.id_dispenser = \''.$id.'\'');
	return $app->json($cats);
});


// API : get cat by its ID
// battery, weight, daily_activity
$app->get('/cat/{id}/details', function($id) use ($app) {
	global $addr;
	$res = $app['db']->fetchAll('select id_cat from cat c where c.id_cat = \''.$id.'\'');
	if(count($res) == 0)
	{
		$data['error'] = 1;
	}
	else
	{
		/*
		$cats = $app['db']->fetchAll('select c.id_cat, c.name, c.photo from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where u.id_user = \''.$id.'\'');
		
		$data['error'] = 0;
		$data['cats'] = $cats;
		foreach($data['cats'] as $icat => $kcat) {
			$data['cats'][$icat]['ok'] = 1;
			$data['cats'][$icat]['status'] = 'Votre chat est COOL';
		}
		*/
		
		$r = $app['db']->query('select
			c.id_cat,
			c.name,
			c.birth,
			if(photo!=\'\',concat(\'http://'.$addr.'/api/img.php?id_cat=\',c.id_cat),\'\') photo, 
			u.id_user, 
			group_concat(concat(f.id_feedtime,\'||\',f.id_dispenser,\'||\',f.time,\'||\',f.weight,\'||\',f.enabled)) feed_times,
			FLOOR(RAND() * 100) activity,
			(select group_concat(concat(date,\'||\',value)) from cat_measure where measure_type = \'activity\' and id_cat = c.id_cat group by id_cat limit 10) activity_histo
			from cat c join cat_user cu using(id_cat) join user u using(id_user) left join feed_times f on f.id_cat = c.id_cat and f.enabled = 1
			left join dispenser d using(id_dispenser)
			where c.id_cat = \''.$id.'\' group by c.id_cat');
		
		
		$cats = $r->fetchAll();
		$r->closeCursor();
		$data['error'] = 0;
		$data['cats'] = $cats[0];
			$data['cats']['ok'] = 1;
			if($icat == 0)
				$data['cats']['ok'] = 0;
			$data['cats']['status'] = $data['cats']['name'].' va bien !';
			if($icat == 0) {
				$data['cats']['status'] = 'Attention à la nutrition d';
				if(in_array(substr($data['cats']['name'],0,1),array('A','E','I','O','U','Y')))
					$data['cats']['status'] .= '\'';
				else
					$data['cats']['status'] .= 'e ';
				$data['cats']['status'] .= $data['cats']['name'];
			}
			$feedtimes = explode(',',$data['cats']['feed_times']);
			$data['cats']['feed_times'] = array();
			foreach($feedtimes as $k => $v) {
				if($v != '') {
					$feedtime = explode('||',$v);
					$data['cats']['feed_times'][] = array('id_feedtime' => $feedtime[0], 'id_dispenser' => $feedtime[1], 'time' => $feedtime[2], 'weight' => $feedtime[3], 'enabled' => $feedtime[4]);
				}
			}
			$activities = explode(',',$data['cats']['activity_histo']);
			$data['cats']['activity_histo'] = array();
			foreach($activities as $k => $v) {
				if($v != '') {
					$activity = explode('||',$v);
					$data['cats']['activity_histo'][] = array(/*'date' => $activity[0], */'value' => $activity[1]);
				}
			}
			$data['cats']['battery'] = 67;
			$data['cats']['weight'] = 4670;
	}
	
	return $app->json($data);
});


// API : delete a cat
$app->delete('/cat/{id}', function(Request $request) use ($app) {
	$id = $request->request->get('id_cat');
	return $app->json(deleteId('id_cat',$id,'cat'), 201);
});

// API : update a cat
$app->post('/cat', function (Request $request) use ($app) {
	$id = $request->request->get('id_cat');
	
	$cols = array('name','birth','photo');
	
	$upd_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '') {
			if($col == 'photo') { // photo is transmitted in base64
				if(strlen($request->request->get($col)) < 1)
					$upd_col[] = $col.' = NULL';
				else {
					if(base64_decode($request->request->get($col)) === false)
						$upd_col[] = $col.' = \''.base64_decode($request->request->get($col)).'\'';
				}
			}
			else
				$upd_col[] = $col.' = \''.$request->request->get($col).'\'';
		}
	
	$upd_sql = "update cat set ";
	$upd_sql .= implode(', ',$upd_col);
	$upd_sql .= " where id_cat = $id";
	
	$r = $app['db']->query($upd_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    $post = array(
        'error' => $error,
        'id_cat'  => $request->request->get('id_cat'),
	'sql' => $upd_sql,
	'postdata' => $request->request->all()
    );
	
	return $app->json($post);
});

?>
