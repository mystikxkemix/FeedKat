<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// Used to display durations
function duree($time) {
	$tabTime = array("jours" => 86400,
			"heures" => 3600,
			"minutes" => 60,
			"secondes" => 1);

	$result = "";

	foreach($tabTime as $unitTime => $nbSecInUnit) {
		if($nbSecInUnit != 1 || ($nbSecInUnit == 1 && $result == '')) {
			$$unitTime = floor($time/$nbSecInUnit);
			$time = $time%$nbSecInUnit;
			
			if($$unitTime > 0 || !empty($result))
				$result .= $$unitTime." $unitTime ";
		}
	}
	
	return rtrim($result);
}


// API : get dispensers by user ID
$app->get('/dispenser/user/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select id_dispenser, name, stock, serial, last_lifesign, onbattery_from, powerdown_from from dispenser where id_user = \''.$id.'\'');
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
		
		$post['error'] = (int) $error;
		$post['id_dispenser'] = (int) $app['db']->lastInsertId();
	}
	return $post;
}

$app->put('/dispenser/hello/{id_user}/{serial}', function (Request $request, $id_user, $serial) use ($app) {
//$app->put('/hello', function (Request $request) use ($app) {
	//$cols = array('name', 'id_user', 'serial');
	$cols = array('serial','id_user');
	
	$ins_col = array();
	foreach($cols as $col)
		if($$col != '')
			$ins_col[$col] = $$col;
	$insert = addDispenser($ins_col);
	
	if($insert['error'] == 0) { // then create a link between dispenser and user 
		$app['db']->query('insert ignore into user_dispenser (id_user,id_dispenser) values (\''.$ins_col['id_user'].'\', \''.$insert['id_dispenser'].'\')');
		$app['db']->query('insert ignore into cat_dispenser (id_cat, id_dispenser)
				select cu.id_cat, ud.id_dispenser
				from cat_user cu join user_dispenser ud using(id_user)');
	}
	
    //return $app->json($insert);
    return convertToSimpleMsg($insert,array('error','id_dispenser'));
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
	$serial = $request->request->get('serial');
	
	$cols = array('name', 'id_user', 'stock');
	
	$upd_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '')
			$upd_col[] = $col.' = \''.$request->request->get($col).'\'';
	
	$upd_sql = "update dispenser set ";
	$upd_sql .= implode(', ',$upd_col);
	if($serial != '')
		$where_sql = " where serial = '$serial'";
	else
		$where_sql = " where id_dispenser = $id";
	
	$upd_sql .= $where_sql;
	
	$r = $app['db']->query($upd_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
	if(!($r = $app['db']->fetchAll('select id_dispenser from dispenser'.$where_sql)))
		return array('error' => 1);
	
    $post = array(
        'error' => (int) $error,
        'id_dispenser'  => (int) $r[0]['id_dispenser']
    );
	
	return $app->json($post);
});

$app->post('/dispenser/lifesign/{serial}', function (Request $request,$serial) use ($app) {
//$app->get('/lifesign/{serial}', function (Request $request,$serial) use ($app) {
	//$serial = $request->request->get('serial');
	$r = $app['db']->query('update dispenser set last_lifesign = UNIX_TIMESTAMP() where serial = \''.$serial.'\'');
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;
	
	if($error == 0) $return = 'LIFESIGN_OK';
	else $return = 'LIFESIGN_KO';
	
	// update available
	//$return = 'UP';
	
	return $return;
});

$app->post('/dispenser/batterymode/{serial}', function (Request $request,$serial) use ($app) {
//$app->get('/batterymode/{serial}', function (Request $request,$serial) use ($app) {
	
	$r = $app['db']->query('update dispenser set onbattery_from = UNIX_TIMESTAMP() where serial = \''.$serial.'\' and onbattery_from is null');
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;
	
	if($error == 0) $return = 'BATTMODE_OK';
	else $return = 'BATTMODE_KO';

	// update available
	//$return = 'UP';

	return $return;
});

$app->post('/dispenser/powerup/{serial}', function (Request $request,$serial) use ($app) {
//$app->get('/powerdown/{serial}', function (Request $request,$serial) use ($app) {
	
	$r = $app['db']->query('update dispenser set onbattery_from = NULL where serial = \''.$serial.'\' and onbattery_from is not null');
	// powerdown mode automatically disabled when dispenser is plugged in
	$r = $app['db']->query('update dispenser set powerdown_from = NULL where serial = \''.$serial.'\' and powerdown_from is not null');
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;

	if($error == 0) $return = 'POWERUP_OK';
	else $return = 'POWERUP_KO';

	// update available
	//$return = 'UP';

	return $return;
});

$app->post('/powerdown/{serial}', function (Request $request,$serial) use ($app) {
//$app->get('/powerdown/{serial}', function (Request $request,$serial) use ($app) {

	$r = $app['db']->query('update dispenser set powerdown_from = UNIX_TIMESTAMP() where serial = \''.$serial.'\' and powerdown_from is null');

	if($r !== false) {
		$error = 0;
	} else $error = 1;

	if($error == 0) $return = 'POWERDOWN_OK';
	else $return = 'POWERDOWN_KO';

	// update available
	//$return = 'UP';

	return $return;
});


$app->post('/dispenser/{serial}/stock/{stock}', function (Request $request,$serial,$stock) use ($app) {
	$r = $app['db']->query('update dispenser set stock = '.$stock.' where serial = \''.$serial.'\'');
	
	if($r !== false) {
		$error = 0;
	} else $error = 1;

	if($error == 0) $return = 'STOCK_OK';
	else $return = 'STOCK_KO';

	// update available
	//$return = 'UP';

	return $return;
});


$app->get('/alerts/{serial}', function (Request $request,$serial) use ($app) {

	$data = $app['db']->fetchAll('select \'onbattery\' alert, (UNIX_TIMESTAMP() - onbattery_from) amount from dispenser where onbattery_from is not null and serial = \''.$serial.'\' and powerdown_from is null
			union
			select \'powerdown\' alert, (UNIX_TIMESTAMP() - powerdown_from) amount from dispenser where powerdown_from is not null and serial = \''.$serial.'\'
			union
			select \'lifesign\' alert, (UNIX_TIMESTAMP() - last_lifesign) amount from dispenser where (UNIX_TIMESTAMP() - last_lifesign) > 3600 and serial = \''.$serial.'\' and powerdown_from is null
			union
			select \'foodstock\' alert, stock amount from dispenser where stock < 25 and serial = \''.$serial.'\'
			union
			select concat(\'collar_battery_\',cl.serial) alert, c.last_battery amount from dispenser d join cat_dispenser cd using (id_dispenser) join cat c using(id_cat) join collar cl using(id_cat) where d.serial = \''.$serial.'\' and c.last_battery < 25');
	
	$alert_caption =
		array(
				'onbattery' => 'Distributeur non branché au secteur',
				'powerdown' => 'Distributeur éteint',
				'lifesign' => 'Distributeur hors-ligne',
				'foodstock' => 'Faible réserve de croquettes',
				'collar_battery' => 'Niveau de pile faible');

	$return['alerts'] = array();
	
	foreach($data as $k=>$v) {
		$return['alerts'][$v['alert']] = new stdClass;
		if($v['alert'] != 'foodstock' && strstr($v['alert'],'collar_battery') === false) {
			$return['alerts'][$v['alert']]->duration = (int) $v['amount'];
			$duration_caption = 'depuis '.duree($v['amount']);
			$return['alerts'][$v['alert']]->caption = $alert_caption[$v['alert']].' '.$duration_caption;
		}
		elseif(strstr($v['alert'],'collar_battery') !== false) {
				$return['alerts'][$v['alert']]->level = (int) $v['amount'];
				$return['alerts'][$v['alert']]->caption = $alert_caption['collar_battery'].' ('.$v['amount'].'%)';
				$col_serial = substr($v['alert'],strlen('collar_battery_'));
				$return['alerts']['collar_battery'][$col_serial] = $return['alerts'][$v['alert']];
				unset($return['alerts'][$v['alert']]);
		}
		else {
			$return['alerts'][$v['alert']]->level = (int) $v['amount'];
			$return['alerts'][$v['alert']]->caption = $alert_caption[$v['alert']].' ('.$v['amount'].'%)';

		}
	}

	return $app->json($return);
});

// API : get config by dispenser serial
$app->get('/dispenser/params/{serial}', function(Request $request, $serial) use ($app) {
	/*
	$d= $app['db']->fetchAll('select id_dispenser, stock, last_params from dispenser where serial = \''.$serial.'\'');
	$d = $data[0];
	*/
	$txt = 'DISPENSER_PARAMS\r\n';
	
	//$txt .= convertToSimpleMsg(array($d['id_dispenser'], $d['stock']), array('id_dispenser','stock'));
	$sql = 'select 
		ifnull(cl.serial,\'------\') serial,
		ifnull(group_concat(concat(DATE_FORMAT(f.time,\'%H%i\'),\'||\',LPAD(f.weight,3,\'0\'))), \'\') feed_times
	from cat c 
	join cat_dispenser cd using(id_cat) 
	join dispenser d using(id_dispenser) 
	left join feed_times f on f.id_cat = c.id_cat and f.enabled = 1 and f.weight > 0
	left join collar cl on c.id_cat = cl.id_cat
	where d.serial = \''.$serial.'\'
	group by c.id_cat';
	
	$d = $app['db']->fetchAll($sql);
	
	$i=0;
	foreach($d as $k=>$v) {
		$i++;
		if($i > 1)
			$txt .= '\r\n';
		$txt .= $v['serial'].'|FT['.$v['feed_times'].']FT';
		//print_r($v);
	}
	
	if(count($data) == 0)
		$data = array('error' => 1);
	else {
		$data = array('error' => 0, 'dispensers' => $data);
	}
	return $txt;
	//return $app->json($data);
});


$app->get('/time', function (Request $request) use ($app) {
	return time();
});


?>