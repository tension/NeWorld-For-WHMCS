<div class="view">
	<a class="left-menu-toggle">
		<span class="pane"></span>
		<span class="pane"></span>
		<span class="pane"></span>
	</a>
	<div class="left-menu">
		<header class="header">
			<a class="navbar-brand" href="{$WEB_ROOT}/index.php" title="{$companyname}">{$companyname}</a>
		</header>
		<div class="left-menu-wrap">
			<section class="menu">
				<ul>
			        <li class="item {if $templatefile == 'clientareahome'}active{/if}">
			        	<a href="clientarea.php"><i class="alico icon-menu"></i>{$LANG.clientareatitle}</a>
			        </li>
				    {if $registerdomainenabled || $transferdomainenabled}
			        <li class="item {if $templatefile == 'clientareadomains'} active{/if}">
			            <a href="javascript:;"><i class="alico icon-yuming"></i>{$LANG.navdomains}<span class="fa fa-caret-down"></span>
			        	</a>
			            <ul>
							{if $loggedin}
			                <li><a href="clientarea.php?action=domains">{$LANG.clientareanavdomains}</a></li>
			                <li><a href="cart.php?gid=renewals">{$LANG.navrenewdomains}</a></li>
							{/if}
			                {if $condlinks.domainreg}
			                <li><a href="cart.php?a=add&domain=register">{$LANG.navregisterdomain}</a></li>
			                {/if}
			                {if $condlinks.domaintrans}
			                <li><a href="cart.php?a=add&domain=transfer">{$LANG.navtransferdomain}</a></li>
			                {/if}
			                {if $enomnewtldsenabled}
			                <li><a href="{$enomnewtldslink}">Preregister New TLDs</a></li>
			                {/if}
			                <li><a href="domainchecker.php">{$LANG.navwhoislookup}</a></li>
			            </ul>
			        </li>
			        {/if}
			        <li class="item {if $templatefile == 'clientareaproducts' || $templatefile == 'clientareaproductdetails'} active{/if}">
			            <a href="javascript:;"><i class="alico icon-ecs"></i>{$LANG.navservices}<span class="fa fa-caret-down"></span></a>
			            <ul>
							{if $loggedin}
			                <li><a href="clientarea.php?action=services">{$LANG.clientareanavservices}</a></li>
			                {/if}
			                <li><a href="cart.php">{$LANG.navservicesorder}</a></li>
			                <li><a href="cart.php?gid=addons">{$LANG.clientareaviewaddons}</a></li>
			            </ul>
			        </li>
					{if $loggedin}
			        <li class="item {if $templatefile == 'clientareainvoices' || $templatefile == 'clientareaquotes' || $templatefile == 'clientareacreditcard' || $templatefile == 'clientareaaddfunds' || $templatefile == 'masspay'} active{/if}">
			            <a href="javascript:;"><i class="alico icon-expense"></i>{$LANG.navbilling}<span class="fa fa-caret-down"></span></a>
			            <ul>
			                <li><a href="clientarea.php?action=invoices">{$LANG.invoices}</a></li>
			                <li><a href="clientarea.php?action=quotes">{$LANG.quotestitle}</a></li>
			                {if $condlinks.addfunds}
			                <li><a href="clientarea.php?action=addfunds">{$LANG.addfunds}</a></li>
			                {/if}
			                {if $condlinks.masspay}
			                <li><a href="clientarea.php?action=masspay&all=true">{$LANG.masspaytitle}</a></li>
			                {/if}
			                {if $condlinks.updatecc}
			                <li><a href="clientarea.php?action=creditcard">{$LANG.navmanagecc}</a></li>
			                {/if}
			            </ul>
			        </li>
			        <li class="item {if $templatefile == 'supportticketsubmit-stepone' || $templatefile == 'supportticketsubmit-steptwo' || $templatefile == 'supportticketsubmit-kbsuggestions' || $templatefile == 'supportticketsubmit-customfields' || $templatefile == 'supportticketslist' || $templatefile == 'knowledgebase'} active{/if}">
			            <a href="javascript:;"><i class="alico icon-pen"></i>{$LANG.navsupport}<span class="fa fa-caret-down"></span></a>
			            <ul>
			        		<li><a href="submitticket.php">{$LANG.navopenticket}</a></li>
			                <li><a href="supporttickets.php">{$LANG.navtickets}</a></li>
			                <li><a href="knowledgebase.php">{$LANG.knowledgebasetitle}</a></li>
			            </ul>
			        </li>
			        <li class="item {if $templatefile == 'clientareadetails' || $templatefile == 'clientareacontacts' || $templatefile == 'clientareachangepw' || $templatefile == 'clientareaemails'} active{/if}">
			            <a href="javascript:;"><i class="alico icon-account-2"></i>{$LANG.account}<span class="fa fa-caret-down"></span>
				        </a>
			            <ul>
			                <li><a href="clientarea.php?action=details">{$LANG.clientareanavdetails}</a></li>
			                <li><a href="clientarea.php?action=contacts">{$LANG.clientareanavcontacts}</a></li>			                							<li><a href="clientarea.php?action=changepw">{$LANG.clientareanavchangepw}</a></li>
							<li><a href="clientarea.php?action=emails">{$LANG.navemailssent}</a></li>
			            </ul>
			        </li>
			        {/if}
			        <li class="item {if $templatefile == 'announcements'}active{/if}">
			        	<a href="announcements.php">
				        	<i class="fa fa-bell"></i>{$LANG.announcementstitle}
				        </a>
			        </li>
					{if $loggedin}
			        <li class="item {if $templatefile == 'downloads'}active{/if}">
			        	<a href="downloads.php">
				        	<i class="fa fa-cloud-download"></i>{$LANG.downloadstitle}
				        </a>
			        </li>
			        {if $condlinks.networkstatus}
			        <li class="item {if $templatefile == 'serverstatus'}active{/if}">
			        	<a href="serverstatus.php">
				        	<i class="fa fa-dot-circle-o"></i>{$LANG.networkstatustitle}
				        </a>
			        </li>
			        {/if}
			        {if $condlinks.affiliates}
			        <li class="item {if $templatefile == 'affiliates'}active{/if}">
			        	<a href="affiliates.php">
			        		<i class="fa fa-universal-access"></i>{$LANG.affiliatestitle}
			        	</a>
			        </li>
			        {/if}
			        {/if}
				</ul>
			</section>
		</div>
		{if $loggedin}
		<section class="account account button-more button-more--noresponsive">
			<div class="center ng-binding">
				<div class="logout"><a href="logout.php" title="{$LANG.logouttitle}"><i class="md md-settings-power"></i></a>
				</div>
				{$clientsdetails.lastname}{$clientsdetails.firstname}
				<span class="label">{$clientsdetails.companyname}</span>
			</div>
		</section>
		{/if}
	</div>
	<div class="right-content">