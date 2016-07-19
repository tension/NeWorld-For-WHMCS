<section class="loginform">
	<div class="row">
		<div class="logincontainer">
			<a class="navbar-brand" href="{$WEB_ROOT}/index.php" title="{$companyname}">{$companyname}</a>
			<div class="login-content">
	
			    {if $loggedin}
			        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.noPasswordResetWhenLoggedIn textcenter=true}
			    {else}
			        {if $success}
			
			            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.pwresetvalidationsent textcenter=true}
						<div class="form-group" style="padding-bottom: 30px;">
			            	<p>{$LANG.pwresetvalidationcheckemail}</p>
						</div>
			
			        {else}
			
			            {if $errormessage}
			                {include file="$template/includes/alert.tpl" type="error" msg=$errormessage textcenter=true}
			            {/if}
			
			            {if $securityquestion}
			
			                <div class="form-group">
				                <p>{$LANG.pwresetsecurityquestionrequired}</p>
			                </div>
			
			                <form method="post" action="pwreset.php"  class="form-stacked">
			                    <input type="hidden" name="action" value="reset" />
			                    <input type="hidden" name="email" value="{$email}" />
			
			                    <div class="form-group">
			                        <label for="inputAnswer">{$securityquestion}</label>
			                        <input type="text" name="answer" class="form-control" id="inputAnswer" autofocus>
			                    </div>
			
			                    <div class="form-group" style="padding-bottom: 30px;">
			                        <button type="submit" class="btn btn-success btn-block">{$LANG.pwresetsubmit}</button>
			                    </div>
			
			                </form>
			
			            {else}
			
			                <form method="post" action="{$systemsslurl}pwreset.php" role="form">
			                    <input type="hidden" name="action" value="reset" />
								
			                    <div class="alert alert-warning">
									<p>{$LANG.pwresetemailneeded}</p>
			                    </div>
			
			                    <div class="form-group">
			                        <label for="inputEmail">{$LANG.loginemail}</label>
			                        <input type="email" name="email" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
			                    </div>
			
			                    <div class="form-group" style="padding-bottom: 30px;">
			                        <button type="submit" class="btn btn-success btn-block">{$LANG.pwresetsubmit}</button>
			                    </div>
			
			                </form>
			
			            {/if}
			
			        {/if}
			    {/if}
			</div>
		    <div class="nav">
				<p class="back"><a href="#" onClick="javascript :history.go(-1);"><i class="fa fa-angle-double-left" aria-hidden="true"></i> {$LANG.goback}</a></p>
		    </div>
		</div>
