<section class="loginform">
	<div class="row">
		<div class="logincontainer col-sm-12">
			
			<a class="navbar-brand" href="{$WEB_ROOT}/index.php" title="{$companyname}">{$companyname}</a>
			
			<div class="login-content">

			    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.logoutsuccessful textcenter=true}
			
			    <div class="foot text-center">
			        <a href="index.php" class="btn btn-default">{$LANG.logoutcontinuetext}</a>
			    </div>
			</div>
		</div>
	</div>
</div>
