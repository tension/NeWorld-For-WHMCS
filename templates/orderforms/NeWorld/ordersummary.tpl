<span class="product-name">{$producttotals.productinfo.name}</span>
<span class="product-group">{$producttotals.productinfo.groupname}</span>

<div class="clearfix">
    <span class="pull-left">{$producttotals.productinfo.name}</span>
    <span class="pull-right">{$producttotals.pricing.baseprice}</span>
</div>

{foreach $producttotals.configoptions as $configoption}
    {if $configoption}
        <div class="clearfix">
            <span class="pull-left">&nbsp;&raquo; {$configoption.name}: {$configoption.optionname}</span>
            <span class="pull-right">{$configoption.recurring}{if $configoption.setup} + {$configoption.setup} {$LANG.ordersetupfee}{/if}</span>
        </div>
    {/if}
{/foreach}

{foreach $producttotals.addons as $addon}
    <div class="clearfix">
        <span class="pull-left">+ {$addon.name}</span>
        <span class="pull-right">{$addon.recurring}</span>
    </div>
{/foreach}

{if $producttotals.pricing.setup || $producttotals.pricing.recurring || $producttotals.pricing.addons}
    <div class="summary-totals">
        {if $producttotals.pricing.setup}
            <div class="clearfix">
                <span class="pull-left">{$LANG.cartsetupfees}:</span>
                <span class="pull-right">{$producttotals.pricing.setup}</span>
            </div>
        {/if}
        {foreach from=$producttotals.pricing.recurringexcltax key=cycle item=recurring}
            <div class="clearfix">
                <span class="pull-left">{$cycle}:</span>
                <span class="pull-right">{$recurring}</span>
            </div>
        {/foreach}
        {if $producttotals.pricing.tax1}
            <div class="clearfix">
                <span class="pull-left">{$carttotals.taxname} @ {$carttotals.taxrate}%:</span>
                <span class="pull-right">{$producttotals.pricing.tax1}</span>
            </div>
        {/if}
        {if $producttotals.pricing.tax2}
            <div class="clearfix">
                <span class="pull-left">{$carttotals.taxname2} @ {$carttotals.taxrate2}%:</span>
                <span class="pull-right">{$producttotals.pricing.tax2}</span>
            </div>
        {/if}
    </div>
{/if}

<div class="total-due-today">
    <span class="amt">{$producttotals.pricing.totaltoday}</span>
    <span>{$LANG.ordertotalduetoday}</span>
</div>
