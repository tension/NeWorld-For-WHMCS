<section class="loginform">
	<div class="row">
		<div class="logincontainer col-sm-12">
			<a class="navbar-brand" href="{$WEB_ROOT}/index.php" title="{$companyname}">{$companyname}</a>
			<div class="login-content" style="padding-bottom: 20px;">
			    {if $invalidlink}
			
			        {include file="$template/includes/alert.tpl" type="danger" msg=$invalidlink textcenter=true}
			
			    {elseif $success}
			
			        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.pwresetvalidationsuccess textcenter=true}
			
			        <p class="text-center">
			            {$LANG.pwresetsuccessdesc|sprintf2:'<a href="clientarea.php">':'</a>'}
			        </p>
			
			    {else}
			
			        {if $errormessage}
			            {include file="$template/includes/alert.tpl" type="danger" msg=$errormessage textcenter=true}
			        {/if}
			
			        <div class="form-group">
				        <p>{$LANG.pwresetenternewpw}</p>
			        </div>
			
			        <form class="using-password-strength" method="post" action="{$smarty.server.PHP_SELF}?action=pwreset">
			            <input type="hidden" name="key" id="key" value="{$key}" />
			
			            <div id="newPassword1" class="form-group has-feedback">
			                <label class="control-label" for="inputNewPassword1">{$LANG.newpassword}</label>
			                <input type="password" name="newpw" id="inputNewPassword1" class="form-control" autocomplete="off" />
			                <span class="form-control-feedback glyphicon glyphicon-password"></span>
			            </div>
			
			            <div id="newPassword2" class="form-group has-feedback">
			                <label class="control-label" for="inputNewPassword2">{$LANG.confirmnewpassword}</label>
			                <input type="password" name="confirmpw" id="inputNewPassword2" class="form-control" autocomplete="off" />
			                <span class="form-control-feedback glyphicon glyphicon-password"></span>
			                <div id="inputNewPassword2Msg"></div>
			            </div>
			
			            <div class="form-group">
			                <label class="control-label">{$LANG.pwstrength}</label>
			                {include file="$template/includes/pwstrength.tpl"}
			            </div>
			
			            <div class="form-group">
			                <div class="text-center">
			                    <input class="btn btn-primary" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
			                    <input class="btn btn-default" type="reset" value="{$LANG.cancel}" />
			                </div>
			            </div>
			
			        </form>
			
			    {/if}
			</div>
		    <div class="nav">
				<p class="back"><a href="#" onClick="javascript :history.go(-1);"><i class="fa fa-angle-double-left" aria-hidden="true"></i> 返回</a></p>
		    </div>
		</div>