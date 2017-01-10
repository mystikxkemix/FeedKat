<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get dispensers by user ID
$app->get('/dispenser/user/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select id_dispenser, name, stock from dispenser where id_user = \''.$id.'\'');
	if(count($data) == 0)
		$data = array('error' => 1);
	else {
		$data = array('error' => 0, 'dispensers' => $data);
	}
	return $app->json($data);
});

function convertToSimpleMsg($array = array(), $cols = array()) { // return a string with data separated with |
	$array_clean = array_merge(array_flip($cols), array_intersect_key($array, array_flip($cols))); 
	
	return implode('|',
        array_map(                     // each value of... -----------------+
            function ($value) {        //                                   |
                return str_pad(                     // padded               |
                    $value, 3, '0', STR_PAD_LEFT    // with leading zeros   |
                );                                  //                      |
            },                         //                                   |
            $array_clean                     // <----------- ... the array -------+
        )
    );
}

function addDispenser($cols = array()) {
	global $app;
	$post = array();
	$ins_col = array();
	foreach($cols as $col => $coldata)
		$ins_col[$col] = '\''.$coldata.'\'';
	
	$data = $app['db']->fetchAll('select id_dispenser from dispenser where serial = '.$ins_col['serial']);
	if(count($data) > 0) {
		$post['error'] = 1;
		$post['error_msg'] = 'serial already used';
		$post['id_dispenser'] = 0;
	}
	else {
		$ins_sql = "insert into dispenser ";
		$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
		$ins_sql .= " values (";
		$ins_sql .= implode(', ',$ins_col).')';
		
		$r = $app['db']->query($ins_sql);
		
		if($r !== false)
			$error = 0;
		else
			$error = 1;
		
		$post['error'] = $error;
		$post['id_dispenser'] = $app['db']->lastInsertId();
	}
	return $post;
}

//$app->get('/hello/{id_user}/{serial}', function (Request $request, $id_user, $serial) use ($app) {
$app->put('/hello', function (Request $request) use ($app) {
	$cols = array('name', 'id_user', 'serial', 'stock');

	$ins_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '')
		//if($$col != '')
			$ins_col[$col] = $request->request->get($col);
			//$ins_col[$col] = $$col;
	$insert = addDispenser($ins_col);
	
	if($insert['error'] == 0) { // then create a link between dispenser and user 
		$app['db']->query('insert into user_dispenser (id_user,id_dispenser) values (\''.$ins_col['id_user'].'\', \''.$insert['id_dispenser'].'\')');
		$app['db']->query('insert into cat_dispenser (id_cat, id_dispenser)
				select cu.id_cat, ud.id_dispenser
				from cat_user cu join user_dispenser ud using(id_user)');
	}
	
    return $app->json($insert);
    //return convertToSimpleMsg($insert,array('error','id_dispenser'));
});

// API : add a new dispenser
$app->put('/dispenser', function (Request $request) use ($app) {
	$cols = array('name', 'id_user', 'serial', 'stock');
	
	$ins_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '')
			$ins_col[$col] = $request->request->get($col);
	
    return $app->json(addDispenser($ins_col));
});

// API : update a dispenser
$app->post('/dispenser', function (Request $request) use ($app) {
	$id = $request->request->get('id_dispenser');
	
	$cols = array('name', 'id_user', 'stock');
	
	$upd_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '')
			$upd_col[] = $col.' = \''.$request->request->get($col).'\'';
	
	$upd_sql = "update dispenser set ";
	$upd_sql .= implode(', ',$upd_col);
	$upd_sql .= " where id_dispenser = $id";
	
	$r = $app['db']->query($upd_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    $post = array(
        'error' => $error,
        'id_dispenser'  => $request->request->get('id_dispenser')
    );
	
	return $app->json($post);
});

$app->post('/lifesign', function (Request $request) use ($app) {
//$app->get('/lifesign/{serial}', function (Request $request,$serial) use ($app) {
	$serial = $request->request->get('serial');
	$r = $app['db']->query('update dispenser set last_lifesign = UNIX_TIMESTAMP() where serial = \''.$serial.'\'');
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;
	
	if($error == 0) $return = 'OK';
	else $return = 'KO';
	
	// update available
	//$return = 'UP';
	
	return $return;
});

$app->post('/batterymode', function (Request $request) use ($app) {
//$app->get('/batterymode/{serial}/{mode}', function (Request $request,$serial,$mode) use ($app) {
	$serial = $request->request->get('serial');
	$mode = $request->request->get('mode');
	
	if($mode == 1)
		$r = $app['db']->query('update dispenser set onbattery_from = UNIX_TIMESTAMP() where serial = \''.$serial.'\' and onbattery_from is null');
	else {
		$r = $app['db']->query('update dispenser set onbattery_from = NULL where serial = \''.$serial.'\' and onbattery_from is not null');
		// powerdown mode automatically disabled when dispenser is plugged in
		$r = $app['db']->query('update dispenser set powerdown_from = NULL where serial = \''.$serial.'\' and powerdown_from is not null');
	}
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;
	
	if($error == 0) $return = 'OK';
	else $return = 'KO';

	// update available
	//$return = 'UP';

	return $return;
});

$app->post('/powerdown', function (Request $request) use ($app) {
//$app->get('/powerdown/{serial}/{mode}', function (Request $request,$serial,$mode) use ($app) {
	$serial = $request->request->get('serial');
	$mode = $request->request->get('mode');

	if($mode == 1)
		$r = $app['db']->query('update dispenser set powerdown_from = UNIX_TIMESTAMP() where serial = \''.$serial.'\' and powerdown_from is null');
		else
			$r = $app['db']->query('update dispenser set powerdown_from = NULL where serial = \''.$serial.'\' and powerdown_from is not null');

			if($r !== false) {
				$error = 0;
			} else $error = 1;

			if($error == 0) $return = 'OK';
			else $return = 'KO';

			// update available
			//$return = 'UP';

			return $return;
});


$app->post('/dispenser/{serial}/stock/{stock}', function (Request $request,$serial,$stock) use ($app) {
	$r = $app['db']->query('update dispenser set stock = '.$stock.' where serial = \''.$serial.'\'');
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;

	if($error == 0) $return = 'OK';
	else $return = 'KO';

	// update available
	//$return = 'UP';

	return $return;
});

?>