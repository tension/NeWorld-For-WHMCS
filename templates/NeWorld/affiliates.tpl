{if $inactive}

    {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.affiliatesdisabled textcenter=true}

{else}
<div class="row">
	<div class="col-sm-5">
		<div class="affiliate-referral-link text-center">
			<div class="main">	
				<h2>{$LANG.affiliatesreferallink}</h2>
				<p style="text-align:center;margin-top:-40px;">
					<img src="{$WEB_ROOT}/templates/{$template}/assets/img/link.png" style="width:55px;">
				</p>
				<div class="info">
					<div class="form-group">
						<input type="text" value="{$referrallink}" class="form-control">
						<input type="submit" name="Submit" value="{$LANG.copy}" class="btn" id="updatelanding">
					</div>
				</div>
			</div>
		</div>
		{if $withdrawrequestsent}
		    <div class="alert alert-success">
		        <p>{$LANG.affiliateswithdrawalrequestsuccessful}</p>
		    </div>
		{else}
		    <p class="text-center">
		        <a href="{$smarty.server.PHP_SELF}?action=withdrawrequest" class="btn btn-lg btn-danger"{if !$withdrawlevel} disabled="true"{/if} style="border-radius: 4px;padding: 10px 40px;">
		            <i class="fa fa-bank"></i> {$LANG.affiliatesrequestwithdrawal}
		        </a>
		    </p>
		    {if !$withdrawlevel}
		        <p class="text-muted text-center">{lang key="affiliateWithdrawalSummary" amountForWithdrawal=$affiliatePayoutMinimum}</p>
		    {/if}
		{/if}
	</div>
	<div class="col-sm-7">
		<div class="affiliates">
			<div class="slider">
				<p>您的推介成果<br>Your referral results</p>
			</div>
		    <div class="well">
			    <div aria-hidden="true" class="icon">
				    <img src="{$WEB_ROOT}/templates/{$template}/assets/img/Street-View.svg" class="theme-grey size-md" />
			    </div>
			    <div class="main">
				    <span>{$LANG.affiliatesclicks}</span>
			    	{$visitors}
			    </div>
			</div>
				
			<div class="well">
		    	<div aria-hidden="true" class="icon">
				    <img src="{$WEB_ROOT}/templates/{$template}/assets/img/Networking-1.svg" class="theme-grey size-md" />
			    </div>
				<div class="main">
					<span>{$LANG.affiliatessignups}</span>
					{$signups}
				</div>
		    </div>
			    
		    <div class="well">
		    	<div aria-hidden="true" class="icon">
				    <img src="{$WEB_ROOT}/templates/{$template}/assets/img/Dot-Chart 1.svg" class="theme-grey size-md" />
			    </div>
				<div class="main">
			    	<span>{$LANG.affiliatesconversionrate}</span>
			    	{$conversionrate}%
			    </div>
		    </div>
			    
		    <div class="well">
		    	<div aria-hidden="true" class="icon">
				    <img src="{$WEB_ROOT}/templates/{$template}/assets/img/Coin-and Cash.svg" class="theme-grey size-md" />
			    </div>
				<div class="main">
					<span>{$LANG.affiliatescommissionspending}</span>
					{$pendingcommissions}
				</div>
		    </div>
			    
		    <div class="well">
		    	<div aria-hidden="true" class="icon">
				    <img src="{$WEB_ROOT}/templates/{$template}/assets/img/Cash-Payment.svg" class="theme-grey size-md" />
			    </div>
				<div class="main">
					<span>{$LANG.affiliatescommissionsavailable}</span>
					{$balance}
				</div>
		    </div>
			    
		    <div class="well">
		    	<div aria-hidden="true" class="icon">
				    <img src="{$WEB_ROOT}/templates/{$template}/assets/img/Money-Bag.svg" class="theme-grey size-md" />
			    </div>
				<div class="main">
					<span>{$LANG.affiliateswithdrawn}</span>
					{$withdrawn}
				</div>
		    </div>
		</div>
	</div>
</div>

<div class="empty_space" style="height: 30px"></div>

{include file="$template/includes/subheader.tpl" title=$LANG.affiliatesreferals}

{include file="$template/includes/tablelist.tpl" tableName="AffiliatesList"}
<script type="text/javascript">
    jQuery(document).ready( function ()
    {
        var table = jQuery('#tableAffiliatesList').removeClass('hidden').DataTable();
        {if $orderby == 'regdate'}
            table.order(0, '{$sort}');
        {elseif $orderby == 'product'}
            table.order(1, '{$sort}');
        {elseif $orderby == 'amount'}
            table.order(2, '{$sort}');
        {elseif $orderby == 'status'}
            table.order(4, '{$sort}');
        {/if}
        table.draw();
        jQuery('#tableLoading').addClass('hidden');
    });
</script>
<div class="table-container clearfix">
    <table id="tableAffiliatesList" class="table table-list hidden">
        <thead>
            <tr>
                <th>{$LANG.affiliatessignupdate}</th>
                <th>{$LANG.orderproduct}</th>
                <th>{$LANG.affiliatesamount}</th>
                <th>{$LANG.affiliatescommission}</th>
                <th>{$LANG.affiliatesstatus}</th>
            </tr>
        </thead>
        <tbody>
        {foreach from=$referrals item=referral}
            <tr class="text-center">
                <td><span class="hidden">{$referral.datets}</span>{$referral.date}</td>
                <td>{$referral.service}</td>
                <td>{$referral.amountdesc}</td>
                <td>{$referral.commission}</td>
                <td><span class='label status status-{$referral.status|strtolower}'>{$referral.status}</span></td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    <div class="text-center" id="tableLoading">
        <p><i class="fa fa-spinner fa-spin"></i> {$LANG.loading}</p>
    </div>
</div>

{if $affiliatelinkscode}
    {include file="$template/includes/subheader.tpl" title=$LANG.affiliateslinktous}
    <div class="margin-bottom text-center">
        {$affiliatelinkscode}
    </div>
{/if}

{/if}
