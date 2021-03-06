<?php
// API : get all feed times
$app->get('/feedtimes', function() use ($app) {
    $times = $app['db']->fetchAll('select * from feed_times');
	return $app->json($times);
})->bind('api_feed_times');

// API : get a feed time
$app->get('/feedtimes/{id}', function($id) use ($app) {
    $times = $app['db']->fetchAll('select * from feed_times where id_feedtime = \''.$id.'\'');
	return $app->json($times);
})->bind('api_feed_time');

// API : get feed times by cat ID
$app->get('/feedtimes/cat/{id}', function($id) use ($app) {
    $times = $app['db']->fetchAll('select f.* from feed_times f join cat c using(id_cat) where c.id_cat = \''.$id.'\'');
	return $app->json($times);
})->bind('api_feed_times_by_cat');


$app->post('/feedtimes', function (Request $request) use ($app) {
	$id = $request->request->get('id_feedtime');
	
	$data_feedtime = array('id_cat','id_dispenser','time','weight','enabled');
	
	$upd_col = array();
	foreach($data_feedtime as $col)
		if($request->request->get($col) != '')
			$upd_col[] = $col.' = \''.$request->request->get($col).'\'';
	
	
	$upd_sql = "update feed_times set ";
	$upd_sql .= implode(', ',$upd_col);
	$upd_sql .= " where id_feedtime = $id";
	
	$r = $app['db']->query($upd_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    $post = array(
        'error' => $error,
        'id_feedtime'  => $request->request->get('id_feedtime')
    );
	
    return $app->json($post);
});


$app->delete('/feedtimes', function (Request $request) use ($app) {
	$id = $request->request->get('id_feedtime');
	return $app->json(deleteId('id_feedtime',$id,'feed_times'));
});

$app->put('/feedtimes', function (Request $request) use ($app) {
	$data_feedtime = array('id_cat','id_dispenser','time','weight','enabled');
	
	$upd_col = array();
	foreach($data_feedtime as $col)
		if($request->request->get($col) != '')
			$ins_col[$col] = '\''.$request->request->get($col).'\'';
	
	$ins_sql = "insert into feed_times ";
	$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
	$ins_sql .= " values (";
	$ins_sql .= implode(', ',$ins_col).')';
	
	$r = $app['db']->query($ins_sql);
		
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    $post = array(
        'error' => $error,
        'id_feedtime'  => $app['db']->lastInsertId()
    );
	
    return $app->json($post, 201);
});
?>