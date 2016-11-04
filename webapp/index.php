<?php session_start();?>
<!doctype html>
<html lang="fr">
<head>

  <title>Accueil</title>
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
			<h1>Accueil</h1>
        </div>
		
		
		
		<!-- /content -->
		<div data-role="page" data-title="Accueil" data-theme="a" id="page-info" data-cache="false">	
			
			<div role="main" class="ui-content">
				
				<!-- Tuile Alerte -->
<!--				<div class="ui-shadow ui-tile-alert">
					<div class="tile-alert-photo">
						<img src="icons/icon_alerte.png" height="65" width="65">
					</div>
					<div class="tile-alert-text" >
					Alerte
					</div>
				</div>
-->				
				
				<div class="ui-grid-a">
				
					<div class="ui-block-a index-block-chat-a">	
					<!-- Tuile informations -->
					</div>
					
					<div class="ui-block-b index-block-chat-b">		
					<!-- Tuile informations -->
					</div>
					
				</div>
				
				<div class="ui-grid-a">
				
					<div class="ui-block-a index-block-distrib-a">	
					<!-- Tuile distributeur -->	
					</div>
					
					<div class="ui-block-b" id="index-block-distrib-b">		
					<!-- Tuile distributeur -->
					</div>
					
				</div>
				
			</div>
			
		</div>
	 
	 
		<!--/footer -->
        <?php include 'footer.php'; ?>


</body>
</html>