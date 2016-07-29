<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$companyname} - {$pagetitle}</title>

    <!-- Bootstrap -->
    <link href="{$BASE_PATH_CSS}/bootstrap.min.css" rel="stylesheet">
    <link href="{$BASE_PATH_CSS}/font-awesome.min.css" rel="stylesheet">

    <!-- Styling -->
	<link href="templates/{$template}/assets/css/select2.min.css" rel="stylesheet">
    <link href="templates/{$template}/assets/css/invoice.css" rel="stylesheet">
	
	<!-- jQuery -->
	<script src="{$BASE_PATH_JS}/jquery.min.js"></script>
	<script src="templates/{$template}/assets/js/select2.min.js"></script>

</head>
<body>

<script>
$(function () {
	$('select').select2({
		minimumResultsForSearch: Infinity
	});
});
</script>

<div class="invoice">
    <div class="container">
	    <div class="invoice-container">

        {if $invalidInvoiceIdRequested}

            {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoiceserror bodyTextCenter=true}

        {else}
			<div class="header">
	            <div class="row">
	                <div class="col-sm-6 col-xs-6">
	
	                    {if $logo}
	                        <p><img src="{$logo}" title="{$companyname}" /></p>
	                    {else}
	                        <h2 class="logo">{$companyname}</h2>
	                    {/if}
	                   
	                    <div class="invoice-status">
	                        {if $status eq "Draft"}
	                            <span class="draft">{$LANG.invoicesdraft}</span>
	                        {elseif $status eq "Unpaid"}
	                            <span class="unpaid">{$LANG.invoicesunpaid}</span>
	                        {elseif $status eq "Paid"}
	                            <span class="paid">{$LANG.invoicespaid}</span>
	                        {elseif $status eq "Refunded"}
	                            <span class="refunded">{$LANG.invoicesrefunded}</span>
	                        {elseif $status eq "Cancelled"}
	                            <span class="cancelled">{$LANG.invoicescancelled}</span>
	                        {elseif $status eq "Collections"}
	                            <span class="collections">{$LANG.invoicescollections}</span>
	                        {/if}
	                    </div>
	                    
	                    {if $status eq "Unpaid" || $status eq "Draft"}
	                        <div>
	                            {$LANG.invoicesdatedue}: {$datedue}
	                        </div>
	                    {/if}
	
	                </div>
	                <div class="col-sm-6 col-xs-6 text-right">
		                
		                <p class="black">Invoice</p>
		                <p class="gery">{$pagetitle}</p>
		                <p class="gery">{$date}</p>
	
	                </div>
	            </div>
			</div>
			<!-- header end -->

            {if $paymentSuccess}
                {include file="$template/includes/panel.tpl" type="success" headerTitle=$LANG.success bodyContent=$LANG.invoicepaymentsuccessconfirmation bodyTextCenter=true}
            {elseif $pendingReview}
                {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.success bodyContent=$LANG.invoicepaymentpendingreview bodyTextCenter=true}
            {elseif $paymentFailed}
                {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoicepaymentfailedconfirmation bodyTextCenter=true}
            {elseif $offlineReview}
                {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.success bodyContent=$LANG.invoiceofflinepaid bodyTextCenter=true}
            {/if}

            {if $manualapplycredit}
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <h3 class="panel-title"><strong>{$LANG.invoiceaddcreditapply}</strong></h3>
                    </div>
                    <div class="panel-body">
                        <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
                            <input type="hidden" name="applycredit" value="true" />
                            {$LANG.invoiceaddcreditdesc1} <strong>{$totalcredit}</strong>. {$LANG.invoiceaddcreditdesc2}. {$LANG.invoiceaddcreditamount}:
                            <div class="row">
                                <div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-4">
                                    <div class="input-group">
                                        <input type="text" name="creditamount" value="{$creditamount}" class="form-control" />
                                        <span class="input-group-btn">
                                            <input type="submit" value="{$LANG.invoiceaddcreditapply}" class="btn btn-success" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            {/if}

            {if $notes}
                {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.invoicesnotes bodyContent=$notes}
            {/if}

            <div class="contets">
                <div class="table-responsive">
                    <table class="table table-condensed">
                        <tbody>
                            {foreach from=$invoiceitems item=item}
                                <tr>
                                    <td class="font16 fontweight300">{$item.description}{if $item.taxed eq "true"} *{/if}</td>
                                    <td class="text-right green">{$item.amount}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                    
                    <div class="invoice-total">
	                    <p class="text-right">
	                        <strong class="gray">{$LANG.invoicessubtotal}</strong>
	                        <span>{$subtotal}</span>
	                    </p>
	                    {if $taxrate}
	                    <p class="text-right">
                            <strong class="gray">{$taxrate}% {$taxname}</strong>
                            <span>{$tax}</span>
	                    </p>
	                    {/if}
	                    {if $taxrate2}
	                    <p class="text-right">
                            <strong class="gray">{$taxrate2}% {$taxname2}</strong>
                            <span>{$tax2}</span>
	                    </p>
	                    {/if}
	                    <p class="text-right">
	                        <strong class="gray">{$LANG.invoicescredit}</strong>
	                        <span>{$credit}</span>
	                    </p>
	                    <p class="text-right">
	                        <strong>{$LANG.invoicestotal}</strong>
	                        <span class="green font20">{$total}</span>
	                    </p>
	                </div>
                </div>
            </div>

            {if $taxrate}
                <p>* {$LANG.invoicestaxindicator}</p>
            {/if}

            <div class="transactions-container small-text">
                <div class="table-responsive">
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <td><strong>{$LANG.invoicestransdate}</strong></td>
                                <td><strong>{$LANG.invoicestransgateway}</strong></td>
                                <td><strong class="hidden-xs">{$LANG.invoicestransid}</strong></td>
                                <td class="text-right"><strong>{$LANG.invoicestransamount}</strong></td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$transactions item=transaction}
                                <tr>
                                    <td>{$transaction.date}</td>
                                    <td>{$transaction.gateway}</td>
                                    <td><span class="hidden-xs">{$transaction.transid}</span></td>
                                    <td class="text-right">{$transaction.amount}</td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="4">{$LANG.invoicestransnonefound}</td>
                                </tr>
                            {/foreach}
                            <tr>
                                <td class="text-right" colspan="3"><strong>{$LANG.invoicesbalance}</strong></td>
                                <td class="text-right">{$balance}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
			<div class="footer">
	            <div class="row">
	                <div class="col-sm-4 pull-sm-right text-right-sm">
	                    <strong class="gray mrb10">{$LANG.invoicespayto}:</strong>
	                    <address>
	                        {$payto}
	                    </address>
	                </div>
	                <div class="col-sm-4">
	                    <strong class="gray mrb10">{$LANG.invoicesinvoicedto}:</strong>
	                    <address>
	                        {if $clientsdetails.companyname}{$clientsdetails.companyname}<br />{/if}
	                        {$clientsdetails.firstname} {$clientsdetails.lastname}<br />
	                        {$clientsdetails.address1}, {$clientsdetails.address2}<br />
	                        {$clientsdetails.city}, {$clientsdetails.state}, {$clientsdetails.postcode}<br />
	                        {$clientsdetails.country}
	                        {if $customfields}
	                        <br /><br />
	                        {foreach from=$customfields item=customfield}
	                        {$customfield.fieldname}: {$customfield.value}<br />
	                        {/foreach}
	                        {/if}
	                    </address>
	                </div>
	                <div class="col-sm-4">
	                    <strong class="gray mrb10">{$LANG.paymentmethod}:</strong>
	                    <span>
	                        {if $status eq "Unpaid" && $allowchangegateway}
	                            <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
	                                {$gatewaydropdown}
	                            </form>
	                        {else}
	                            {$paymentmethod}
	                        {/if}
	                    </span>
	                    {if $status eq "Unpaid" || $status eq "Draft"}
	                        <div class="payment-btn-container">
	                            {$paymentbutton}
	                        </div>
	                    {/if}
	                </div>
	            </div>
			</div>

        {/if}
	    </div>
	    <div class="pull-right btn-group btn-group-sm hidden-print">
	        <a href="javascript:window.print()" class="btn btn-default"><i class="fa fa-print"></i> {$LANG.print}</a>
	        <a href="dl.php?type=i&amp;id={$invoiceid}" class="btn btn-default"><i class="fa fa-download"></i> {$LANG.invoicesdownload}</a>
	    </div>
	
		<p class="pull-left hidden-print"><a href="clientarea.php"> <i class="fa fa-angle-double-left" aria-hidden="true"></i> {$LANG.invoicesbacktoclientarea}</a></a></p>
    </div>
</div>
<script src="https://use.typekit.net/jrq2vzx.js"></script>
<script>try{ Typekit.load({ async: true }); }catch(e){ }</script>
</body>
</html>
