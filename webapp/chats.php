<?php session_start();?>
<!doctype html>
<html lang="fr">
<head>

  <title>Chats</title>
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
			<h1>Chats</h1>
        </div>
		
		
	 
		<!-- /content -->
		<div data-role="page" data-title="Chats" data-theme="a" id="page-cat" data-cache="false">
		
			<div role="main" class="ui-content">
		
				<div class="ui-grid-a grid-a-25_75">
					<!-- Liste des chats -->
					<div class="ui-block-a list-cat">
						
						<!--<div class="ui-tile-btn ui-shadow" id="cat0">Chat</div>
						<div class="ui-tile-btn ui-shadow" id="cat1">Lapin</div>
						<div class="ui-tile-btn ui-shadow ui-btn-icon-top ui-icon-myadd" ></div>-->
						
					</div>
					
					<div class="ui-block-b">
					
						<!-- Tuile Information -->
						<div data-role="collapsible" class="ui-shadow ui-tile-collapsible" data-inset="true" data-collapsed="false" data-collapsed-icon="carat-r" data-expanded-icon="carat-d" data-iconpos="right" >
							<h1>
								<div style="text-align:center">Information</div>
							</h1>
							<div class="info-content">
							</div>
						</div>	
						
						
						<!-- Tuile FeedTime -->
						<div data-role="collapsible" class="ui-shadow ui-tile-collapsible" data-inset="true" data-collapsed="true" data-collapsed-icon="carat-r" data-expanded-icon="carat-d" data-iconpos="right" >
							<h1>
								<div style="text-align:center">FeedTime</div>
							</h1>
							
							<div class="tile-text">
								FeedTime
							</div>
						</div>
						
						
						<!-- Tuile Graphique -->
						<div data-role="collapsible" class="ui-shadow ui-tile-collapsible" data-inset="true" data-collapsed="true" data-collapsed-icon="carat-r" data-expanded-icon="carat-d" data-iconpos="right" >
							<h1>
								<div style="text-align:center">Graphique</div>
							</h1>
							
							<div>
								
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