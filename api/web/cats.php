<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

function getCatInfo($keys = array(), $details = false) {
	global $app, $addr;
	
	$details = true;
	
	foreach($keys as $k=>$v) {
		$keys[$k] = addslashes($v);
	}
	$wheres = array();
	if(isset($keys['id_cat']) && $keys['id_cat'] != '')
		$wheres[] = 'c.id_cat = '.$keys['id_cat'];
	if(isset($keys['id_dispenser']) && $keys['id_dispenser'] != '') {
		$res = $app['db']->fetchAll('select id_dispenser from dispenser d where d.id_dispenser = \''.$keys['id_dispenser'].'\'');
		if(count($res) == 0) return array('error' => 1);
		$wheres[] = 'd.id_dispenser = \''.$keys['id_dispenser'].'\'';
	}
	if(isset($keys['id_user']) && $keys['id_user'] != '') {
		$res = $app['db']->fetchAll('select id_user from user u where u.id_user = \''.$keys['id_user'].'\'');
		if(count($res) == 0) return array('error' => 1);
		$wheres[] = 'u.id_user = '.$keys['id_user'];
	}
	if(count($wheres) > 0)
		$where = 'where '.implode(' and ', $wheres).' '; 
	else
		$where = '';
	
	$r = $app['db']->fetchAll('select
		c.id_cat,
		c.name,
		c.birth,
		if(photo!=\'\',concat(\'http://'.$addr.'/api/img.php?id_cat=\',c.id_cat),\'\') photo,
		ifnull(d.id_dispenser,\'\') id_dispenser, 
		ifnull(u.id_user,\'\') id_user,
		ifnull(group_concat(concat(f.id_feedtime,\'||\',f.id_dispenser,\'||\',f.time,\'||\',f.weight,\'||\',f.enabled)), \'\') feed_times,
		ifnull(last_activity,\'\') last_activity,
		ifnull(last_battery,\'\') last_battery,
		(select group_concat(concat(date,\'||\',value)) from cat_measure where measure_type = \'activity\' and id_cat = c.id_cat group by id_cat limit 1) activity,
		(select group_concat(concat(date,\'||\',value)) from cat_measure where measure_type = \'weight\' and id_cat = c.id_cat group by id_cat limit 1) weight'.
			($details == true ? ',
		(select group_concat(concat(date,\'||\',value)) from cat_measure where measure_type = \'activity\' and id_cat = c.id_cat group by id_cat limit 10) activity_histo,
		(select group_concat(concat(date,\'||\',value)) from cat_measure where measure_type = \'weight\' and id_cat = c.id_cat group by id_cat limit 10) weight_histo' : '').'
		
		from 
			cat c 
		left join 
			cat_dispenser cd using(id_cat) left join dispenser d using(id_dispenser) 
		left join 
			user u using(id_user) 
		left join 
			feed_times f on f.id_cat = c.id_cat and f.enabled = 1
		'.$where.'group by c.id_cat');
	
	if(count($r) > 0)
		$data['cats'] = $r;
	
	if(count($data['cats']) > 0) {
		foreach($data['cats'] as $i => $cat) {
			$feedtimes = explode(',',$data['cats'][$i]['feed_times']);
			$data['cats'][$i]['feed_times'] = array();
			foreach($feedtimes as $k => $v) {
				if($v != '') {
					$feedtime = explode('||',$v);
					$data['cats'][$i]['feed_times'][] = array('id_feedtime' => (int) $feedtime[0], 'id_dispenser' => (int) $feedtime[1], 'time' => $feedtime[2], 'weight' => (int) $feedtime[3], 'enabled' => (int) $feedtime[4]);
				}
			}
			
			
			$data['cats'][$i]['ok'] = 1;
			$data['cats'][$i]['status'] = $data['cats'][$i]['name'].' va bien !';
			if($i == 0) {
				$data['cats'][$i]['status'] = 'Attention à la nutrition d';
				if(in_array(substr($data['cats'][$i]['name'],0,1),array('A','E','I','O','U','Y')))
					$data['cats'][$i]['status'] .= '\'';
					else
						$data['cats'][$i]['status'] .= 'e ';
						$data['cats'][$i]['status'] .= $data['cats'][$i]['name'];
			}

			
			// Battery
			$data['cats'][$i]['battery'] = (int) 67;
			// Activity
			$activities = explode(',',$data['cats'][$i]['activity_histo']);
			$data['cats'][$i]['activity_histo'] = array();
			foreach($activities as $k => $v) {
				if($v != '') {
					$activity = explode('||',$v);
					$data['cats'][$i]['activity_histo'][] = /*array('date' => $activity[0], 'value' => */(int)$activity[1];//);
				}
			}
			$data['cats'][$i]['activity'] = (int)reset($data['cats'][$i]['activity_histo']);
			// Weight
			$weights = explode(',',$data['cats'][$i]['weight_histo']);
			$data['cats'][$i]['weight_histo'] = array();
			foreach($weights as $k => $v) {
				if($v != '') {
					$weight = explode('||',$v);
					$data['cats'][$i]['weight_histo'][] = /*array('date' => $activity[0], 'value' => */(int) $weight[1];//);
				}
			}
			$data['cats'][$i]['weight'] = (int)reset($data['cats'][$i]['weight_histo']);
			
			// DETAILS
			
			// END DETAILS
			
			foreach($cat as $fname => $fdata) {
				if(strstr($fname, 'id_') !== false || in_array($fname, array('enabled', 'activity'))) {
					$data['cats'][$i][$fname] = (int) $data['cats'][$i][$fname];
				}
			}
		}
		$data['error'] = 0;
		$data['count'] = count($data['cats']);
	}
	else {
		$data['error'] = 1;
		$data['count'] = count($data['cats']);
	}
	return $data;
}

// API : get all cats
$app->get('/cat', function() use ($app) {
	return $app->json(getCatInfo());
});

// API : get a specific cat
$app->get('/cat/{id}', function($id) use ($app) {
	return $app->json(getCatInfo(array('id_cat' => $id)));
});

// API : get cats by dispenser ID
$app->get('/cat/dispenser/{id}', function($id) use ($app) {
	return $app->json(getCatInfo(array('id_dispenser' => $id)));
});


// API : get cats by user ID
$app->get('/cat/user/{id}', function($id) use ($app) {
	return $app->json(getCatInfo(array('id_user' => $id)));
});


// API : get cat by its ID
// battery, weight, daily_activity
$app->get('/cat/{id}/details', function($id) use ($app) {
	return $app->json(getCatInfo(array('id_cat' => $id)), true);
});

$app->put('/cat', function (Request $request) use ($app) {

	$cols = array('name','birth','photo_type','photo');
	
	$ins_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '') {
			if($col == 'photo') { // photo is transmitted in base64
				if(strlen($request->request->get($col)) < 1)
					$ins_col[] = $col.' = NULL';
				else {
					if(base64_decode($request->request->get($col)))
						$ins_col[] = $col.' = X\''.bin2hex(base64_decode($request->request->get($col))).'\'';
				}
			}
			else
				$ins_col[] = $col.' = \''.$request->request->get($col).'\'';
		}
	
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

// API : delete a cat
$app->delete('/cat/{id}', function(Request $request) use ($app) {
	$id = $request->request->get('id_cat');
	return $app->json(deleteId('id_cat',$id,'cat'), 201);
});

// API : update a cat
$app->post('/cat', function (Request $request) use ($app) {
	$id = $request->request->get('id_cat');
	$cols = array('name','birth','photo_type','photo');
	
	$upd_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '') {
			if($col == 'photo') { // photo is transmitted in base64
				if(strlen($request->request->get($col)) < 1)
					$upd_col[] = $col.' = NULL';
				else {
					if(base64_decode($request->request->get($col)))
						$upd_col[] = $col.' = X\''.bin2hex(base64_decode($request->request->get($col))).'\'';
				}
			}
			else
				$upd_col[] = $col.' = \''.$request->request->get($col).'\'';
		}
	
	if($request->request->get('collar_mac') != '') {
		$upd_col[] = 'update collar set id_cat = '.$id.' where mac = \''.$request->request->get('collar_mac').'\'';
	}
	
	if(count($upd_col) > 0) {
		$upd_sql = "update cat set ";
		$upd_sql .= implode(', ',$upd_col);
		$upd_sql .= " where id_cat = $id";
		
		//return $app->json($upd_sql);
		$r = $app['db']->query($upd_sql);
	
		if($r !== false)
			$error = 0;
		else
			$error = 1;
	}
	else
		$error = 1;
	
    $post = array(
        'error' => $error,
        'id_cat'  => $request->request->get('id_cat')/*,
		'fields' => $upd_col*/
		//'sql' => $upd_sql,
		//'postdata' => $request->request->all()
    );
	
	return $app->json($post);
});

?>