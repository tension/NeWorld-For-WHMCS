<style>
#main-body {
	min-height: auto;
	border-radius: 4px;
	border-bottom: 1px solid #E7E9ED;
}
.content2 {
    margin: 25px 27px 0;
}
.client-home-panels .panel-default {
	border-radius: 4px;
	box-shadow: none;
    border-bottom: 1px solid #E7E9ED;
}
.client-home-panels .panel > .panel-heading {
	background-image: none;
}
.client-home-panels .panel .panel-title {
	color: #333;
	font-size: 14px;
	line-height: 26px;
}
.client-home-panels .panel > .panel-footer {
	display: none;
}
.list-group {
	margin-bottom: 0;
}
</style>
<div class="home-section-user">
	<div class="user-part-header pull-left">
		<a class="user-header ng-scope" href="clientarea.php?action=details">
			<img width="50" height="50" src="//gravatar.moefont.com/avatar/{$clientsdetails.email|md5}?s=100&d={$systemurl}templates/{$template}/assets/img/default_family.jpg" alt="" />
		</a>
		<div class="user-name">
			<span class="text-muted">Hi,</span> <a class="text-primary" href="clientarea.php?action=details">{$clientsdetails.lastname}{$clientsdetails.firstname}</a>
		</div>
		<div class="user-aff ng-scope">
			<a target="_blank" href="announcements.php">
				<i class="fa fa-bell"></i>
				<span>{$LANG.announcementstitle}</span>
			</a>
		</div>
	</div>
	<div class="user-part-body">
		<div class="user-part-account ng-scope">
			<div class="user-body-title">
				余额<span class="home-colon">:</span>
			</div>
			<div class="user-body-main">
				<div class="user-balance">
					<span class="ng-binding mymoeny" data-money="{$clientsstats.creditbalance}">0</span><span class="user-balance-small ng-binding">.00</span><span class="user-small">元</span>
				</div>
			</div>
			<div>
				{if $condlinks.addfunds}
				<a class="btn btn-sm btn-success margin-right-2 ng-binding" href="clientarea.php?action=addfunds">{$LANG.addfunds}</a>
			    {/if}
				<div class="inline-block">
					<a class="ng-binding" href="">费用中心</a>
				</div>
			</div>
		</div>
		<div class="user-part-todo ng-scope">
			<div class="user-body-title">
				{$LANG.navinvoices}<span class="home-colon">:</span>
			</div>
			<div class="user-body-main">
				<div class="user-renew">
					<span class="ng-binding">{$clientsstats.numunpaidinvoices}</span>
					<a class="user-small" href="clientarea.php?action=masspay&all=true">续费待办</a>
				</div>
			</div>
			<div>
				<div class="user-opt inline-block">
					<a href="clientarea.php?action=services">{$LANG.navservices}</a>
					<span class="margin-left-1 ng-binding">{$clientsstats.productsnumactive}</span>
					<span class="user-opt-gap"></span>
					<a href="clientarea.php?action=domains">{$LANG.navdomains}</a>
					<span class="margin-left-1 ng-binding">{$clientsstats.numactivedomains}</span>
				</div>
			</div>
		</div>
		<div class="user-part-todo ng-scope">
			<div class="user-body-title">
				{$LANG.navtickets}<span class="home-colon">:</span>
			</div>
			<div class="user-body-main">
				<div class="user-renew">
					<span class="ng-binding">{$clientsstats.numactivetickets}</span>
					<a class="user-small" href="supporttickets.php">{$LANG.navtickets}</a>
				</div>
			</div>
			<div>
				<div class="user-opt inline-block">
					{if $condlinks.affiliates}
					<a href="affiliates.php">{$LANG.affiliatestitle}</a>
					<span class="user-opt-gap"></span>
					{/if}
					<a href="clientarea.php?action=quotes">{$LANG.quotes}</a>
					<span class="margin-left-1 ng-binding">{$clientsstats.numquotes}</span>
				</div>
			</div>
		</div>
	</div>
</div>
</section>
<section class="content2">

{foreach from=$addons_html item=addon_html}
    <div>
        {$addon_html}
    </div>
{/foreach}

<div class="client-home-panels">
    <div class="row">
        <div class="col-sm-8">

            {function name=outputHomePanels}
                <div menuItemName="{$item->getName()}" class="panel panel-default"{if $item->getAttribute('id')} id="{$item->getAttribute('id')}"{/if}>
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            {if $item->getExtra('btn-link') && $item->getExtra('btn-text')}
                                <div class="pull-right">
                                    <a href="{$item->getExtra('btn-link')}" class="btn bg-color-{$item->getExtra('color')} btn-xs">
                                        {if $item->getExtra('btn-icon')}<i class="fa {$item->getExtra('btn-icon')}"></i>{/if}
                                        {$item->getExtra('btn-text')}
                                    </a>
                                </div>
                            {/if}
                            {if $item->hasIcon()}<i class="{$item->getIcon()}"></i>&nbsp;{/if}
                            {$item->getLabel()}
                            {if $item->hasBadge()}&nbsp;<span class="badge">{$item->getBadge()}</span>{/if}
                        </h3>
                    </div>
                    <div class="panel-body">
                    {if $item->hasBodyHtml()}
                        {$item->getBodyHtml()}
                    {/if}
                    {if $item->hasChildren()}
                        <div class="list-group{if $item->getChildrenAttribute('class')} {$item->getChildrenAttribute('class')}{/if}">
                            {foreach $item->getChildren() as $childItem}
                                {if $childItem->getUri()}
                                    <a menuItemName="{$childItem->getName()}" href="{$childItem->getUri()}" class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}{if $childItem->isCurrent()} active{/if}"{if $childItem->getAttribute('dataToggleTab')} data-toggle="tab"{/if}{if $childItem->getAttribute('target')} target="{$childItem->getAttribute('target')}"{/if} id="{$childItem->getId()}">
                                        {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>&nbsp;{/if}
                                        {$childItem->getLabel()}
                                        {if $childItem->hasBadge()}&nbsp;<span class="badge">{$childItem->getBadge()}</span>{/if}
                                    </a>
                                {else}
                                    <div menuItemName="{$childItem->getName()}" class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}" id="{$childItem->getId()}">
                                        {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>&nbsp;{/if}
                                        {$childItem->getLabel()}
                                        {if $childItem->hasBadge()}&nbsp;<span class="badge">{$childItem->getBadge()}</span>{/if}
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}
                    </div>
                    <div class="panel-footer">
                        {if $item->hasFooterHtml()}
                            {$item->getFooterHtml()}
                        {/if}
                    </div>
                </div>
            {/function}

            {foreach $panels as $item}
                {if $item@iteration is odd}
                    {outputHomePanels}
                {/if}
            {/foreach}

        </div>
        <div class="col-sm-4">

            {foreach $panels as $item}
                {if $item@iteration is even}
                    {outputHomePanels}
                {/if}
            {/foreach}

        </div>
    </div>
</div>
