<section class="loginform">
	<div class="row">
		<div class="logincontainer col-sm-12">
			
			<a class="navbar-brand" href="{$WEB_ROOT}/index.php" title="{$companyname}">{$companyname}</a>
			
			<div class="login-content">
			
			    <form method="post" action="{$systemsslurl}dologin.php" role="form">
				    
					{if $incorrect}
				        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.loginincorrect textcenter=true}
				    {elseif $verificationId && empty($transientDataName)}
				        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.verificationKeyExpired textcenter=true}
				    {elseif $ssoredirect}
				        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.sso.redirectafterlogin textcenter=true}
				    {/if}
			    
			        <div class="form-group form-group-top">
			            <label for="inputEmail">{$LANG.clientareaemail}</label>
			            <input type="email" name="username" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
			        </div>
			
			        <div class="form-group">
			            <label for="inputPassword">{$LANG.clientareapassword}</label>
			            <input type="password" name="password" class="form-control" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" >
			        </div>
			
			        <div class="form-group">
			            <label>
			                <input type="checkbox" name="rememberme" /> {$LANG.loginrememberme}
			            </label>
			        </div>
			
			        <div class="form-group">
			            <input id="login" type="submit" class="btn btn-success btn-block" value="{$LANG.loginbutton}" />
			        </div>
			        
			        <div class="foot text-center">
				    	<a href="pwreset.php">{$LANG.forgotpw}</a>
			        </div>
			    </form>
			</div>
		    <div class="nav">
				<p class="back"><a href="javascript:;" onClick="javascript :history.go(-1);"><i class="fa fa-angle-double-left" aria-hidden="true"></i> {$LANG.goback}</a></p>
				<p class="register">{$LANG.noaccount} <a href="register.php">{$LANG.register}</a></p>
		    </div>
		
		</div>
