<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get all cats
$app->get('/cat', function() use ($app) {
	return $app->json(getCatInfo());
});

$app->put('/measure/activity', function (Request $request) use ($app) {

	$cols = array('first_time','interval','activities');
	
	$mac = $request->request->get('mac');
	
	
	$ins_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '') {
				$ins_col[] = $col.' = \''.$request->request->get($col).'\'';
		}
	
	$idcat = $app['db']->fetchAll('select id_cat from cat c join collar co using(id_cat) where co.mac = \''.$mac.'\'');
	if($r !== false) {
		$id_cat = $idcat[0]['id_cat'];
	}
	
	echo $id_cat;
	
	$ins_sql = "insert into cat_measure ";
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