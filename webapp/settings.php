<?php session_start();?>
<!doctype html>
<html lang="fr">
<head>

  <title>Options</title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/themes/feedkattheme.css" />
  <link rel="stylesheet" href="css/themes/jquery.mobile.icons.min.css" />
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" /> 
  <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 
  <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script> 
  <script src="footer.js"></script>
  
  <?php $_SESSION['id_user'] = 1;?> <!-- simulation connexion user 1 -->
  <script type="text/javascript">
	var userID = <?php echo $_SESSION['id_user']; ?>;
  </script>
  <script src="dynamic.js"></script> 

</head>
<body>  
 
		<!-- /header -->
        <div data-role="header" data-position="fixed" data-theme="a">
			<h1>Options</h1>
        </div>
 
 
		<!-- /content -->
		<div data-role="page" data-title="Options" data-theme="a">
			<div role="main" class="ui-content">
			
				<div class="ui-grid-a">
				
					<div class="ui-block-a">	
					<!-- Tuile utilisateur -->
						<div class="ui-shadow ui-tile-info">
							<div class="tile-photo">
								<img src="icons/Logo_FeedKat_300px.png" height="150" width="150">
							</div>
							<div class="tile-description">
								<div class="tile-title" >
									Compte utilisateur
								</div>
							</div>
						</div>

						<div class="ui-shadow ui-tile-info">
							<div class="tile-photo">
								<img src="icons/icon_dis.png" height="150" width="150">
							</div>
							<div class="tile-description">
								<div class="tile-title" >
									Distributeur
								</div>
							</div>
						</div>
						
						<div class="ui-shadow ui-tile-info">
							<div class="tile-photo">
								<img src="icons/Logo_FeedKat_300px.png" height="150" width="150">
							</div>
							<div class="tile-description">
								<div class="tile-title" >
									Aide
								</div>	
							</div>
						</div>
						
					</div>
				</div>
				
			</div>
		</div>
 
 
		<!--/footer -->
        <?php include 'footer.php'; ?>

</body>
</html>