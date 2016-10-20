<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// POST : modif. / PUT : inscription / POST : login / DELETE : suppression user

// API : get all users
$app->get('/user', function() use ($app) {
    $data = $app['db']->fetchAll('select u.id_user, u.surname, u.first_name, u.mail from user u');
	return $app->json($data);
})->bind('api_users');

// API : get a specific user
$app->get('/user/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select u.id_user, u.surname, u.first_name, u.mail from user u where u.id_user = \''.$id.'\'');
	if(count($data) != 1)
	{
		$data[0]['error'] = 1;
	}
	else
	{
		$data[0]['error'] = 0;
	}
	return $app->json($data[0]);
})->bind('api_user');

// Register a user
$app->post('/register',  function (Request $request) use ($app) {
	$mail = $request->request->get('mail');
	$pass = $request->request->get('password');
	$surname = $request->request->get('surname');
	$first_name = $request->request->get('first_name');
	
	$salt = sha1($pass.sha1($pass));
	$password = password_hash($pass, PASSWORD_DEFAULT, array('salt' => $salt));
	
	$r = $app['db']->fetchAll('SELECT mail from user WHERE mail = \''.$mail.'\'');

	if(count($r) == 0) { // user doesn't exists
		$r = $app['db']->query('INSERT INTO user (mail,password,salt,surname,first_name) VALUES (\''.$mail.'\', \''.$password.'\', \''.$salt.'\', \''.$surname.'\', \''.$first_name.'\')');
		$new_user = $app['db']->fetchAll('select id_user from user where mail = \''.$mail.'\'');
		$id_user = $new_user[0]['id_user'];
		$error = 0;
	}
	else
		$error = 1;
	
	
	$data = array(
		'error' => $error
	);
	
	if(!$error)
		$data['id_user'] = $id_user;
	
	return $app->json($data);
});


// Login
$app->post('/login',  function (Request $request) use ($app) {
	$mail = $request->request->get('mail');
	$pass = $request->request->get('password');
	
	$r = $app['db']->fetchAll('SELECT mail,password from user WHERE mail = \''.$mail.'\'');
	$pass_bdd = $r[0]['password'];
	
	if(count($r) > 0) { // user exists
		if(password_verify($pass, $pass_bdd)) {
		// l’utilisateur a rentré le bon mot de passe 
			$new_user = $app['db']->fetchAll('select id_user from user where mail = \''.$mail.'\'');
			$id_user = $new_user[0]['id_user'];
			$error = 0;
		}
		else {
		// l’utilisateur n’a pas saisi le bon mot de passe
			$error = 1;
		}
	}
	else
		$error = 1;
	
	
	$data = array(
		'error' => $error
	);
	
	//$data['debug'] = 'SELECT mail,password from user WHERE mail = \''.$mail.'\'';
	//$data['debug2'] = 'count='.count($r);
	//print_r($request->request->all());
	//echo '<br>';
	//print_r($request->getContent());

	
	if(!$error)
		$data['id_user'] = $id_user;
	
	return $app->json($data);
});

/*
// API : get cats by user ID
$app->get('/cat/user/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select c.* from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where u.id_user = \''.$id.'\'');
	return $app->json($cats);
})->bind('api_cats_by_user');

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
*/
?>