<section class="header-nav">
	{if $formaction == 'dologin.php' || $filename == 'logout' || $filename == 'pwreset'}class="login"{elseif $templatefile == 'homepage' || $templatefile == 'vps' || $templatefile == 'pricing' || $templatefile == 'features' || $filename == 'contact' || $filename == 'cart'}
	<div class="container">
	{/if}
	<div class="pull-left">
		{if $showbreadcrumb}{include file="$template/includes/breadcrumb.tpl"}{/if}
	</div>
	<div class="pull-right hidden-xs hidden-sm" style="padding-top: 17px;">
		{if $loggedin}
			<form role="form" method="post" action="clientarea.php?action=kbsearch">
			    <div class="home-kb-search">
			        <input type="text" name="search" class="form-control" placeholder="{$LANG.clientHomeSearchKb}" />
			        <i class="fa fa-search"></i>
			    </div>
			</form>
	        <!-- Language -->
	        {if $languagechangeenabled && count($locales) > 1}
	            <a href="#" class="btn btn-success" data-toggle="popover" id="languageChooser"><i class="fa fa-language"></i></a>
	            <div id="languageChooserContent" class="hidden">
	                <ul>
	                    {foreach from=$locales item=locale}
	                        <li><a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a></li>
	                    {/foreach}
	                </ul>
	            </div>
	        {/if}
        {/if}
        
		<a href="{$WEB_ROOT}/cart.php?a=view" class="btn btn-primary"><i class="fa fa-shopping-cart"></i><span id="cartItemCount" class="badge badge-danger">{$cartitemcount}</span></a>
	</div>
	{if $formaction == 'dologin.php' || $filename == 'logout' || $filename == 'pwreset'}class="login"{elseif $templatefile == 'homepage' || $templatefile == 'vps' || $templatefile == 'pricing' || $templatefile == 'features' || $filename == 'contact' || $filename == 'cart'}
	</div>
	{/if}
</section>