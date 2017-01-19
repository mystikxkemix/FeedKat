<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get all cats
$app->get('/collar', function() use ($app) {
    $data = $app['db']->fetchAll('select * from collar');
	return $app->json($data);
});

function addCollar($ar_fields) {
	$data_cat = $ar_fields;
	
	$ins_col = array();
	foreach($data_cat as $col => $v)
		if($v != '')	
			$ins_col[$col] = '\''.$v.'\'';
	
	$ins_sql = "insert ignore into collar ";
	$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
	$ins_sql .= " values (";
	$ins_sql .= implode(', ',$ins_col).')';
	echo 'sql:';
	echo $ins_sql;
	$r = $app['db']->query($ins_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
	$post['error'] = $error;
	$post['id_collar'] = $app['db']->lastInsertId();
	
	return $post;
}

$app->put('/collar', function (Request $request) use ($app) {
	$data = array('id_cat','serial','mac');
	foreach($data as $v) 
		if($request->request->get($v) != '')
			$fields[$v] = $request->request->get($v);
    return $app->json(addCollar($fields));
});
$app->put('/collar/{serial}', function (Request $request, $serial) use ($app) {
	$data = array('id_cat','mac');
	foreach($data as $v) 
		if($request->request->get($v) != '')
			$fields[$v] = $request->request->get($v);
	$fields['serial'] = $serial;
    return $app->json(addCollar($fields));
});


// API : get a specific collar
$app->get('/collar/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select * from collar where id_collar = \''.$id.'\'');
	return $app->json($data);
});

// API : get cats by cat ID
$app->get('/collar/cat/{id}', function($id) use ($app) {
	$res = $app['db']->fetchAll('select id_cat from cat c where id_cat = \''.$id.'\'');
	if(count($res) == 0)
	{
		$data['error'] = 1;
	}
	else
	{	
		$cats = $app['db']->fetchAll('select c.*, cl.* from cat c join collar cl using(id_cat) where c.id_cat = \''.$id.'\'');
		
		$data['error'] = 0;
		$data['cats'] = $cats;
	}
	
	return $app->json($data);
});

// API : get cats by dispenser ID
$app->get('/cat/dispenser/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select c.* from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where d.id_dispenser = \''.$id.'\'');
	return $app->json($cats);
})->bind('api_cats_by_dispenser');


// API : delete a cat
$app->delete('/cat/{id}', function(Request $request) use ($app) {
	$id = $request->request->get('id_cat');
	return $app->json(deleteId('id_cat',$id,'cat'), 201);
})->bind('api_cat_delete');

/*
$app->put('/feedtimes', function (Request $request) use ($app) {
	$data_feedtime = array('id_cat','id_dispenser','time','weight','enabled');
	*/
	

// API : get free collars by user id
$app->get('/freecollars/user/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select id_collar, serial from collar where id_cat is null and id_user = '.$id.'');
	foreach($cats as $k=>$v) {
		$cats[$k]['id_collar'] = (int) $cats[$k]['id_collar'];
		$cats[$k]['serial'] = $cats[$k]['serial'];
	}
	return $app->json($cats);
});


$app->get('/catbasics/{serial}', function (Request $request, $serial) use ($app) {
	// serial = FKC001
	
	$sql = "select 
		c.id_cat, c.name, c.birth, (select value from cat_measure cm where cm.measure_type = 'weight' and cm.id_cat = c.id_cat order by cm.`date` desc limit 1) weight
	from
		collar cl
	join
		cat c using(id_cat)
	where cl.serial = '$serial'";
	
	$data = $app['db']->fetchAll($sql){0};
	
	$data['error'] = 0;
	
	return $app->json($data);
});

?>