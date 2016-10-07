<?php
// API : get all cats
$app->get('/cat', function() use ($app) {
    $cats = $app['db']->fetchAll('select * from cat');
	return $app->json($cats);
})->bind('api_cats');

// API : get a cat
$app->get('/cat/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select * from cat where id_cat = \''.$id.'\'');
	return $app->json($cats);
})->bind('api_cat');

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
?>