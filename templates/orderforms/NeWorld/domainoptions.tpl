{if $invalid}
    <div class="domain-checker-result-headline domain-checker-unavailable">
        {if $reason}
            {$reason}
        {else}
            {$LANG.cartdomaininvalid}
        {/if}
    </div>
{elseif $alreadyindb}
    <div class="domain-checker-result-headline domain-checker-unavailable">
        {$LANG.cartdomainexists}
    </div>
{else}

    {if $checktype=="register" && $regenabled}

        <input type="hidden" name="domainoption" value="register" />

        {if $status eq "available" || $status eq "error"}

            <div class="domain-checker-result-headline domain-checker-available">
                {$LANG.cartcongratsdomainavailable|sprintf2:$domain}
            </div>

            <input type="hidden" name="domains[]" value="{$searchResults.domainName}" />
            <input type="hidden" name="domainsregperiod[{$domain}]" value="{$searchResults.shortestPeriod.period}" />

            <div class="text-center">
                {if count($searchResults.pricing) == 1}
                    <p class="margin-bottom">{$LANG.orderForm.domainAddedToCart}</p>
                    <button type="button" class="btn btn-default btn-lg margin-bottom">
                        <span class="glyphicon glyphicon-shopping-cart"></span>
                        {$searchResults.shortestPeriod.register}
                    </button>
                {else}
                    <p class="margin-bottom">{$LANG.orderForm.registerLongerAndSave}</p>
                    <div class="btn-group btn-group-lg margin-bottom">
                        <button type="button" class="btn btn-default btn-sm">
                            <span name="{$searchResults.domainName}-selected-price">
                                <b class="glyphicon glyphicon-shopping-cart"></b>
                                {$searchResults.shortestPeriod.period} {$LANG.orderyears} @ {$searchResults.shortestPeriod.register}
                            </span>
                        </button>
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle additional-options" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <b class="caret"></b>
                            <span class="sr-only">
                                {lang key="domainChecker.additionalPricingOptions" domain=$searchResults.domainName}
                            </span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            {foreach $searchResults.pricing as $years => $price}
                                <li>
                                    <a href="#" onclick="selectDomainPricing('{$searchResults.domainName}', '{$price.register}', {$years}, '{$LANG.orderyears}');return false;">
                                        <b class="glyphicon glyphicon-shopping-cart"></b>
                                        {$years} {$LANG.orderyears} @ {$price.register}
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/if}
            </div>


            {assign var='continueok' value=true}

        {elseif $status eq "unavailable"}

            <div class="domain-checker-result-headline domain-checker-unavailable">
                {$LANG.cartdomaintaken|sprintf2:$domain}
            </div>

        {/if}

    {elseif $checktype=="transfer" && $transferenabled}

        <input type="hidden" name="domainoption" value="transfer" />

        {if $status eq "available"}

            <div class="domain-checker-result-headline domain-checker-unavailable">
                {$LANG.carttransfernotregistered|sprintf2:$domain}
            </div>
            <p class="text-center">{$LANG.orderForm.tryRegisteringInstead}</p>

        {elseif $status eq "unavailable" || $status eq "error"}

            <div class="domain-checker-result-headline domain-checker-available">
                {$LANG.carttransferpossible|sprintf2:$domain:$transferprice}
            </div>

            <input type="hidden" name="domains[]" value="{$domain}" />
            <input type="hidden" name="domainsregperiod[{$domain}]" value="{$transferterm}" />

            {assign var='continueok' value=true}

        {/if}

    {elseif $checktype=="owndomain" || $checktype=="subdomain"}

        <input type="hidden" name="domainoption" value="{$checktype}" />
        <input type="hidden" name="sld" value="{$sld}" />
        <input type="hidden" name="tld" value="{$tld}" />
        <script language="javascript">
            domainGotoNextStep();
        </script>

    {/if}

    {if $searchResults.suggestions}

        <div class="sub-heading">
            <span>{$LANG.cartotherdomainsuggestions}</span>
        </div>

        <div class="row domain-suggestions">
            {foreach $searchResults.suggestions as $num => $result}
                <div class="col-sm-6 margin-bottom-5">
                    <input type="hidden" name="domainsregperiod[{$result.domainName}]" value="{$result.shortestPeriod.period}" />
                    <label>
                        <input type="checkbox" name="domains[]" value="{$result.domainName}" id="domainSuggestion{$num}" class="suggested-domains" />
                        {$result.domainName}
                    </label>
                    <div class="pull-right">
                        {if count($result.pricing) > 1}
                            <div class="btn-group domain-suggestion-pricing">
                        {/if}
                        <button type="button" class="btn btn-default btn-sm" onclick="selectDomainPricing('{$result.domainName}', '{$result.shortestPeriod.register}', {$result.shortestPeriod.period}, '{$LANG.orderyears}', '{$num}')">
                            <span name="{$result.domainName}-selected-price">
                                <b class="glyphicon glyphicon-shopping-cart"></b>
                                {$result.shortestPeriod.period} {$LANG.orderyears} @ {$result.shortestPeriod.register}
                            </span>
                        </button>
                        {if count($result.pricing) > 1}
                            <button type="button" class="btn btn-default btn-sm dropdown-toggle additional-options" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <b class="caret"></b>
                                <span class="sr-only">
                                    {lang key="domainChecker.additionalPricingOptions" domain=$result.domainName}
                                </span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                {foreach $result.pricing as $years => $price}
                                    <li>
                                        <a href="#" onclick="selectDomainPricing('{$result.domainName}', '{$price.register}', {$years}, '{$LANG.orderyears}', '{$num}');return false;">
                                            <b class="glyphicon glyphicon-shopping-cart"></b>
                                            {$years} {$LANG.orderyears} @ {$price.register}
                                        </a>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                        {/if}
                    </div>
                </div>
            {/foreach}
        </div>

        {assign var='continueok' value=true}

    {/if}

    {if $continueok}
        <div class="alert alert-info info-text-sm">
            <i class="fa fa-info-circle"></i>
            {$LANG.orderForm.domainAvailabilityCached}
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary btn-lg">
                {$LANG.continue}
                &nbsp;<i class="fa fa-arrow-circle-right"></i>
            </button>
        </div>
    {/if}

{/if}

<script>
    jQuery('input.suggested-domains').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
        increaseArea: '20%'
    });
</script>
