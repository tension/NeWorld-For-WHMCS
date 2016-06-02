<!DOCTYPE html>
<!--
_/_/_/_/_/  _/_/_/_/  _/      _/    _/_/_/  _/_/_/    _/_/    _/      _/   
   _/      _/        _/_/    _/  _/          _/    _/    _/  _/_/    _/    
  _/      _/_/_/    _/  _/  _/    _/_/      _/    _/    _/  _/  _/  _/     
 _/      _/        _/    _/_/        _/    _/    _/    _/  _/    _/_/      
_/      _/_/_/_/  _/      _/  _/_/_/    _/_/_/    _/_/    _/      _/

承接大型网站建设、设计、制作、规划工作！

TEL: 18910030001 MAIL:tension@me.com -->
<html lang="{$LANG.locale}">
<head>
    <meta charset="{$charset}" />
    <meta content="tension,tension@me.com" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>

    {include file="$template/includes/head.tpl"}

    {$headoutput}

</head>

<body {if $formaction == 'dologin.php' || $filename == 'logout' || $filename == 'pwreset'}class="login"{elseif $templatefile == 'homepage' || $templatefile == 'vps' || $templatefile == 'pricing' || $templatefile == 'tos' || $templatefile == 'features' || $filename == "cart" || $filename == 'contact' && !$loggedin} class="nowhmcs"{/if}>
	
{include file="$template/NeWorld/function.tpl"}
{$headeroutput}

{if $adminMasqueradingAsClient}
    <!-- Return to admin link -->
    <div class="alert alert-danger admin-masquerade-notice">
        {$LANG.adminmasqueradingasclient} 
        <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="alert-link">{$LANG.logoutandreturntoadminarea}</a>
    </div>
{elseif $adminLoggedIn}
    <!-- Return to admin link -->
    <div class="alert alert-danger admin-masquerade-notice">
        {$LANG.adminloggedin} 
        <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="alert-link">{$LANG.returntoadminarea}</a>
    </div>
{/if}

{if $formaction == 'dologin.php' || $filename == 'logout' || $filename == 'pwreset' }

{elseif $templatefile == 'homepage' || $templatefile == 'vps' || $templatefile == 'pricing' || $templatefile == 'tos' || $templatefile == 'features' || $filename == "cart" || $filename == 'contact' && !$loggedin}

	{include file="$template/NeWorld/NeWorld-header.tpl" title=$displayTitle desc=$tagline}

	{if $templatefile == 'homepage'}
		{include file="$template/NeWorld/index.tpl" title=$displayTitle desc=$tagline}
	{/if}
	
{else}

	{include file="$template/NeWorld/whmcs-header.tpl" title=$displayTitle desc=$tagline}
	
{/if}

{if $primarySidebar->hasChildren() || $secondarySidebar->hasChildren()}
    {if $primarySidebar->hasChildren()}
		{include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
    {/if}
{/if}
{if !$primarySidebar->hasChildren() && !$showingLoginPage && $templatefile != 'homepage' && $templatefile != 'vps' && $templatefile != 'pricing' && $templatefile != 'features' && $filename != "cart"}
    {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
{/if}

{include file="$template/includes/verifyemail.tpl"}

{if $formaction != 'dologin.php' && $filename != 'logout' && $filename != 'pwreset' && $templatefile != 'homepage' && $templatefile != 'vps' && $templatefile != 'features' && $templatefile != 'pricing' && $filename != "cart"}
		<div class="navbar-collapse-inner {if $templatefile == 'clientareahome' || $templatefile == 'downloads' || $templatefile == 'affiliates' || $templatefile == 'supportticketsubmit-stepone'}fixed{/if}">
			<div class="navbar-collapse-bg"></div>
			<div class="navbar-collapse-icon">
				<i class="alico icon-sm icon-list-open"></i>
				<i class="alico icon-sm icon-list-close"></i>
			</div>
		</div>
	    <div class="sub-menu {if $templatefile == 'clientareahome' || $templatefile == 'downloads' || $templatefile == 'affiliates' || $templatefile == 'supportticketsubmit-stepone'}fixed{/if}">
	        {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}
	    </div>
	    <div class="main-content {if $templatefile == 'clientareahome' || $templatefile == 'downloads' || $templatefile == 'affiliates' || $templatefile == 'supportticketsubmit-stepone'}fixed{/if}">
		<section id="main-body" class="content content--border">
{/if}