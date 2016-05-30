<script>
    // Define state tab index value
    var statesTab = 10;
    // Do not enforce state input client side
    var stateNotRequired = true;
</script>
{include file="orderforms/$carttpl/common.tpl"}
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
<script type="text/javascript" src="{$BASE_PATH_JS}/PasswordStrength.js"></script>
<script>
    window.langPasswordStrength = "{$LANG.pwstrength}";
    window.langPasswordWeak = "{$LANG.pwstrengthweak}";
    window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
    window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
</script>
{function name=getFontAwesomeCCIcon}
    {if $ccType eq "Visa"}
        fa-cc-visa
    {elseif $ccType eq "MasterCard"}
        fa-cc-mastercard
    {elseif $ccType eq "Discover"}
        fa-cc-discover
    {elseif $ccType eq "American Express"}
        fa-cc-amex
    {elseif $ccType eq "JCB"}
        fa-cc-jcb
    {elseif $ccType eq "Diners Club" || $ccType eq "EnRoute"}
        fa-cc-diners-club
    {else}
        fa-credit-card
    {/if}
{/function}

{include file="orderforms/$carttpl/order-top.tpl"}
	
<section class="order-checkout space2x">
	<div class="container">

		<div id="order-standard_cart">
		    <form method="post" action="{$smarty.server.PHP_SELF}?a=checkout" name="orderfrm">
		    <input type="hidden" name="submit" value="true" />
		    <input type="hidden" name="custtype" id="inputCustType" value="{$custtype}" />
			<div class="row">
				<div class="col-sm-8">
					
				    <div class="header-lined">
				        <h1>{$LANG.orderForm.checkout}</h1>
				    </div>
				
				    {if $errormessage}
				        <div class="alert alert-danger checkout-error-feedback" role="alert">
				            <p>{$LANG.orderForm.correctErrors}:</p>
				            <ul>
				                {$errormessage}
				            </ul>
				        </div>
				        <div class="clearfix"></div>
				    {/if}
					
					<div class="check-main">
									
				        <div class="form-group">
				            <p class="small text-muted hide">{$LANG.orderForm.preferredPaymentMethod}</p>
				
				            <div class="payment">
				                {foreach key=num item=gateway from=$gateways}
				                <div class="paytype {$gateway.sysname}">
				                    <input type="radio" name="paymentmethod" value="{$gateway.sysname}" class="payment-methods{if $gateway.type eq "CC"} is-credit-card{/if}"{if $selectedgateway eq $gateway.sysname} checked{/if} id="{$gateway.sysname}" />
				                    <label class="radio-inline" for="{$gateway.sysname}">
				                        <h5>{$gateway.name}</h5>
				                        {if $gateway.sysname eq "alipay"}
				                        	<p>国内最大支付平台，安全保障、支付自如！</p>
				                        {else if $gateway.sysname eq "paypal"}
				                        	<p>国际最大支付平台，安全保障、支付自如！</p>
										{/if}
				                    </label>
				                </div>
				                {/foreach}
				            </div>
				        </div>
						<div class="check-info">
						    <div class="already-registered clearfix">
						        <div class="pull-right">
						            <button type="button" class="btn btn-info{if $loggedin || !$loggedin && $custtype eq "existing"} hidden{/if}" id="btnAlreadyRegistered">
						                {$LANG.orderForm.alreadyRegistered}
						            </button>
						            <button type="button" class="btn btn-warning{if $loggedin || $custtype neq "existing"} hidden{/if}" id="btnNewUserSignup">
						                {$LANG.orderForm.createAccount}
						            </button>
						        </div>
						        <p>{$LANG.orderForm.enterPersonalDetails}</p>
						    </div>
					        
					        <div id="containerExistingUserSignin"{if $loggedin || $custtype neq "existing"} class="hidden"{/if}>
					
					            <div class="sub-heading">
					                <span>{$LANG.orderForm.existingCustomerLogin}</span>
					            </div>
					
					            <div class="row">
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputLoginEmail" class="field-icon">
					                            <i class="fa fa-envelope"></i>
					                        </label>
					                        <input type="text" name="loginemail" id="inputLoginEmail" class="field" placeholder="{$LANG.orderForm.emailAddress}">
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputLoginPassword" class="field-icon">
					                            <i class="fa fa-lock"></i>
					                        </label>
					                        <input type="password" name="loginpassword" id="inputLoginPassword" class="field" placeholder="{$LANG.clientareapassword}">
					                    </div>
					                </div>
					            </div>
					
					        </div>
					
					        <div id="containerNewUserSignup"{if !$loggedin && $custtype eq "existing"} class="hidden"{/if}>
					
					            <div class="sub-heading">
					                <span>{$LANG.orderForm.personalInformation}</span>
					            </div>
					
					            <div class="row">
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputLastName" class="field-icon">
					                            <i class="fa fa-user"></i>
					                        </label>
					                        <input type="text" name="lastname" id="inputLastName" class="field" placeholder="{$LANG.orderForm.lastName}" value="{$clientsdetails.lastname}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputFirstName" class="field-icon">
					                            <i class="fa fa-user"></i>
					                        </label>
					                        <input type="text" name="firstname" id="inputFirstName" class="field" placeholder="{$LANG.orderForm.firstName}" value="{$clientsdetails.firstname}"{if $loggedin} readonly="readonly"{/if} autofocus>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputEmail" class="field-icon">
					                            <i class="fa fa-envelope"></i>
					                        </label>
					                        <input type="email" name="email" id="inputEmail" class="field" placeholder="{$LANG.orderForm.emailAddress}" value="{$clientsdetails.email}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputPhone" class="field-icon">
					                            <i class="fa fa-phone"></i>
					                        </label>
					                        <input type="tel" name="phonenumber" id="inputPhone" class="field" placeholder="{$LANG.orderForm.phoneNumber}" value="{$clientsdetails.phonenumber}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					            </div>
					            
						        <input type="hidden" name="country" value="CN" />
						        <input type="hidden" name="state" value="{$LANG.clientareastate}" />
						        <input type="hidden" name="city" value="{$LANG.clientareacity}" />
						        <input type="hidden" name="postcode" value="100000" />
						        <input type="hidden" name="companyname" value="{$LANG.clientareacompanyname}" />
						        <input type="hidden" name="address1" value="{$LANG.clientareaaddress1}" />
						        <input type="hidden" name="address2" value="{$LANG.clientareaaddress2}" />
								
								<!--
					            <div class="sub-heading">
					                <span>{$LANG.orderForm.billingAddress}</span>
					            </div>
					
					            <div class="row">
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputCompanyName" class="field-icon">
					                            <i class="fa fa-building"></i>
					                        </label>
					                        <input type="text" name="companyname" id="inputCompanyName" class="field" placeholder="{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})" value="{$clientsdetails.companyname}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputAddress1" class="field-icon">
					                            <i class="fa fa-building-o"></i>
					                        </label>
					                        <input type="text" name="address1" id="inputAddress1" class="field" placeholder="{$LANG.orderForm.streetAddress}" value="{$clientsdetails.address1}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputAddress2" class="field-icon">
					                            <i class="fa fa-map-marker"></i>
					                        </label>
					                        <input type="text" name="address2" id="inputAddress2" class="field" placeholder="{$LANG.orderForm.streetAddress2}" value="{$clientsdetails.address2}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group">
						                    <select name="country" id="inputCountry" class="form-control"{if $loggedin} disabled="disabled"{/if}>
						                        {foreach $countries as $countrycode => $countrylabel}
						                            <option value="{$countrycode}"{if (!$country && $countrycode == $defaultcountry) || $countrycode eq $country} selected{/if}>
						                                {$countrylabel}
						                            </option>
						                        {/foreach}
						                    </select>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputState" class="field-icon" id="inputStateIcon">
					                            <i class="fa fa-map-signs"></i>
					                        </label>
					                        <input type="text" name="state" id="inputState" class="field" placeholder="{$LANG.orderForm.state}" value="{$clientsdetails.state}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputCity" class="field-icon">
					                            <i class="fa fa-building-o"></i>
					                        </label>
					                        <input type="text" name="city" id="inputCity" class="field" placeholder="{$LANG.orderForm.city}" value="{$clientsdetails.city}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputPostcode" class="field-icon">
					                            <i class="fa fa-certificate"></i>
					                        </label>
					                        <input type="text" name="postcode" id="inputPostcode" class="field" placeholder="{$LANG.orderForm.postcode}" value="{$clientsdetails.postcode}"{if $loggedin} readonly="readonly"{/if}>
					                    </div>
					                </div>
					            </div>
					            -->
					
					            {if $customfields}
					                <div class="sub-heading">
					                    <span>{$LANG.orderadditionalrequiredinfo}</span>
					                </div>
					                <div class="field-container">
					                    <div class="row">
					                        {foreach $customfields as $customfield}
					                            <div class="col-sm-6">
					                                <div class="form-group">
					                                    <label for="customfield{$customfield.id}">{$customfield.name}</label>
					                                    {$customfield.input}
					                                    {if $customfield.description}
					                                        <span class="field-help-text">
					                                            {$customfield.description}
					                                        </span>
					                                    {/if}
					                                </div>
					                            </div>
					                        {/foreach}
					                    </div>
					                </div>
					            {/if}
					
					        </div>
					
					        {if $domainsinorder}
					
					            <div class="sub-heading">
					                <span>{$LANG.domainregistrantinfo}</span>
					            </div>
					
					            <p class="small text-muted">{$LANG.orderForm.domainAlternativeContact}</p>
					
					            <div class="row margin-bottom">
					                <div class="col-sm-6 col-sm-offset-3">
					                    <select name="contact" id="inputDomainContact" class="field">
					                        <option value="">{$LANG.usedefaultcontact}</option>
					                        {foreach $domaincontacts as $domcontact}
					                            <option value="{$domcontact.id}"{if $contact == $domcontact.id} selected{/if}>
					                                {$domcontact.name}
					                            </option>
					                        {/foreach}
					                        <option value="addingnew"{if $contact == "addingnew"} selected{/if}>
					                            {$LANG.clientareanavaddcontact}...
					                        </option>
					                    </select>
					                </div>
					            </div>
					
					            <div class="row{if $contact neq "addingnew"} hidden{/if}" id="domainRegistrantInputFields">
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCFirstName" class="field-icon">
					                            <i class="fa fa-user"></i>
					                        </label>
					                        <input type="text" name="domaincontactfirstname" id="inputDCFirstName" class="field" placeholder="{$LANG.orderForm.firstName}" value="{$domaincontact.firstname}">
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCLastName" class="field-icon">
					                            <i class="fa fa-user"></i>
					                        </label>
					                        <input type="text" name="domaincontactlastname" id="inputDCLastName" class="field" placeholder="{$LANG.orderForm.lastName}" value="{$domaincontact.lastname}">
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCEmail" class="field-icon">
					                            <i class="fa fa-envelope"></i>
					                        </label>
					                        <input type="email" name="domaincontactemail" id="inputDCEmail" class="field" placeholder="{$LANG.orderForm.emailAddress}" value="{$domaincontact.email}">
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCPhone" class="field-icon">
					                            <i class="fa fa-phone"></i>
					                        </label>
					                        <input type="tel" name="domaincontactphonenumber" id="inputDCPhone" class="field" placeholder="{$LANG.orderForm.phoneNumber}" value="{$domaincontact.phonenumber}">
					                    </div>
					                </div>
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCCompanyName" class="field-icon">
					                            <i class="fa fa-building"></i>
					                        </label>
					                        <input type="text" name="domaincontactcompanyname" id="inputDCCompanyName" class="field" placeholder="{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})" value="{$domaincontact.companyname}">
					                    </div>
					                </div>
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCAddress1" class="field-icon">
					                            <i class="fa fa-building-o"></i>
					                        </label>
					                        <input type="text" name="domaincontactaddress1" id="inputDCAddress1" class="field" placeholder="{$LANG.orderForm.streetAddress}" value="{$domaincontact.address1}">
					                    </div>
					                </div>
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCAddress2" class="field-icon">
					                            <i class="fa fa-map-marker"></i>
					                        </label>
					                        <input type="text" name="domaincontactaddress2" id="inputDCAddress2" class="field" placeholder="{$LANG.orderForm.streetAddress2}" value="{$domaincontact.address2}">
					                    </div>
					                </div>
					                <div class="col-sm-4">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCCity" class="field-icon">
					                            <i class="fa fa-building-o"></i>
					                        </label>
					                        <input type="text" name="domaincontactcity" id="inputDCCity" class="field" placeholder="{$LANG.orderForm.city}" value="{$domaincontact.city}">
					                    </div>
					                </div>
					                <div class="col-sm-5">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCState" class="field-icon">
					                            <i class="fa fa-map-signs"></i>
					                        </label>
					                        <input type="text" name="domaincontactstate" id="inputDCState" class="field" placeholder="{$LANG.orderForm.state}" value="{$domaincontact.state}">
					                    </div>
					                </div>
					                <div class="col-sm-3">
					                    <div class="form-group prepend-icon">
					                        <label for="inputDCPostcode" class="field-icon">
					                            <i class="fa fa-certificate"></i>
					                        </label>
					                        <input type="text" name="domaincontactpostcode" id="inputDCPostcode" class="field" placeholder="{$LANG.orderForm.postcode}" value="{$domaincontact.postcode}">
					                    </div>
					                </div>
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <select name="domaincontactcountry" id="inputDCCountry" class="field">
					                            {foreach $countries as $countrycode => $countrylabel}
					                                <option value="{$countrycode}"{if (!$domaincontact.country && $countrycode == $defaultcountry) || $countrycode eq $domaincontact.country} selected{/if}>
					                                    {$countrylabel}
					                                </option>
					                            {/foreach}
					                        </select>
					                    </div>
					                </div>
					            </div>
					
					        {/if}
					
					        {if !$loggedin}
					
					            <div id="containerNewUserSecurity"{if !$loggedin && $custtype eq "existing"} class="hidden"{/if}>
					
					                <div class="sub-heading">
					                    <span>{$LANG.orderForm.accountSecurity}</span>
					                </div>
					
					                <div class="row">
					                    <div class="col-sm-6">
					                        <div class="form-group prepend-icon">
					                            <label for="inputNewPassword1" class="field-icon">
					                                <i class="fa fa-lock"></i>
					                            </label>
					                            <input type="password" name="password" id="inputNewPassword1" class="field" placeholder="{$LANG.clientareapassword}">
					                        </div>
					                    </div>
					                    <div class="col-sm-6">
					                        <div class="form-group prepend-icon">
					                            <label for="inputNewPassword2" class="field-icon">
					                                <i class="fa fa-lock"></i>
					                            </label>
					                            <input type="password" name="password2" id="inputNewPassword2" class="field" placeholder="{$LANG.clientareaconfirmpassword}">
					                        </div>
					                    </div>
					                    <div class="col-sm-6">
					                        <div class="progress">
					                            <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="passwordStrengthMeterBar">
					                            </div>
					                        </div>
					                    </div>
					                    <div class="col-sm-6">
					                        <p class="text-center small text-muted" id="passwordStrengthTextLabel">{$LANG.pwstrength}: {$LANG.pwstrengthenter}</p>
					                    </div>
					                </div>
					                {if $securityquestions}
					                    <div class="row">
					                        <div class="col-sm-6">
					                            <select name="securityqid" id="inputSecurityQId" class="field">
					                                <option value="">{$LANG.clientareasecurityquestion}</option>
					                                {foreach $securityquestions as $question}
					                                    <option value="{$question.id}"{if $question.id eq $securityqid} selected{/if}>
					                                        {$question.question}
					                                    </option>
					                                {/foreach}
					                            </select>
					                        </div>
					                        <div class="col-sm-6">
					                            <div class="form-group prepend-icon">
					                                <label for="inputSecurityQAns" class="field-icon">
					                                    <i class="fa fa-lock"></i>
					                                </label>
					                                <input type="password" name="securityqans" id="inputSecurityQAns" class="field" placeholder="{$LANG.clientareasecurityanswer}">
					                            </div>
					                        </div>
					                    </div>
					                {/if}
					
					            </div>
					
					        {/if}
					
					        <div class="clearfix"></div>
					
					        <div id="creditCardInputFields"{if $selectedgatewaytype neq "CC"} class="hidden"{/if}>
					            {if $clientsdetails.cclastfour}
					                <div class="row margin-bottom">
					                    <div class="col-sm-12">
					                        <div class="text-center">
					                            <label class="radio-inline">
					                                <input type="radio" name="ccinfo" value="useexisting" id="useexisting" {if $clientsdetails.cclastfour} checked{else} disabled{/if} />
					                                {$LANG.creditcarduseexisting}
					                                {if $clientsdetails.cclastfour}
					                                    ({$clientsdetails.cclastfour})
					                                {/if}
					                            </label>
					                            <label class="radio-inline">
					                                <input type="radio" name="ccinfo" value="new" id="new" {if !$clientsdetails.cclastfour || $ccinfo eq "new"} checked{/if} />
					                                {$LANG.creditcardenternewcard}
					                            </label>
					                        </div>
					                    </div>
					                </div>
					            {else}
					                <input type="hidden" name="ccinfo" value="new" />
					            {/if}
					            <div id="newCardInfo" class="row{if $clientsdetails.cclastfour && $ccinfo neq "new"} hidden{/if}">
					                <div class="col-sm-6">
					                    <div class="form-group">
					                        <input type="hidden" id="cctype" name="cctype" value="{$acceptedcctypes.0}" />
					                        <div class="dropdown" id="cardType">
					                            <button class="btn btn-default dropdown-toggle field" type="button" id="creditCardType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
					                                <span id="selectedCardType">
					                                    <i class="fa {getFontAwesomeCCIcon ccType=$acceptedcctypes.0} fa-fw"></i>
					                                    {$acceptedcctypes.0}
					                                </span>
					                                <span class="fa fa-caret-down fa-fw"></span>
					                            </button>
					                            <ul class="dropdown-menu" id="creditCardTypeDropDown" aria-labelledby="creditCardType">
					                                {foreach $acceptedcctypes as $cardType}
					                                    <li>
					                                        <a href="#">
					                                            <i class="fa {getFontAwesomeCCIcon ccType=$cardType} fa-fw"></i>
					                                            <span class="type">
					                                                {$cardType}
					                                            </span>
					                                        </a>
					                                    </li>
					                                {/foreach}
					                            </ul>
					                        </div>
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputCardNumber" class="field-icon">
					                            <i class="fa fa-credit-card"></i>
					                        </label>
					                        <input type="tel" name="ccnumber" id="inputCardNumber" class="field" placeholder="{$LANG.orderForm.cardNumber}" autocomplete="cc-number">
					                    </div>
					                </div>
					                {if $showccissuestart}
					                    <div class="col-sm-6">
					                        <div class="form-group prepend-icon">
					                            <label for="inputCardStart" class="field-icon">
					                                <i class="fa fa-calendar-check-o"></i>
					                            </label>
					                            <input type="tel" name="ccstartdate" id="inputCardStart" class="field" placeholder="MM / YY ({$LANG.creditcardcardstart})" autocomplete="cc-exp">
					                        </div>
					                    </div>
					                    <div class="col-sm-6">
					                        <div class="form-group prepend-icon">
					                            <label for="inputCardIssue" class="field-icon">
					                                <i class="fa fa-asterisk"></i>
					                            </label>
					                            <input type="tel" name="ccissuenum" id="inputCardIssue" class="field" placeholder="{$LANG.creditcardcardissuenum}">
					                        </div>
					                    </div>
					                {/if}
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputCardExpiry" class="field-icon">
					                            <i class="fa fa-calendar"></i>
					                        </label>
					                        <input type="tel" name="ccexpirydate" id="inputCardExpiry" class="field" placeholder="MM / YY{if $showccissuestart} ({$LANG.creditcardcardexpires}){/if}" autocomplete="cc-exp">
					                    </div>
					                </div>
					                <div class="col-sm-6">
					                    <div class="form-group prepend-icon">
					                        <label for="inputCardCVV" class="field-icon">
					                            <i class="fa fa-barcode"></i>
					                        </label>
					                        <input type="tel" name="cccvv" id="inputCardCVV" class="field" placeholder="{$LANG.orderForm.cvv}" autocomplete="cc-cvc">
					                    </div>
					                </div>
					            </div>
					            <div id="existingCardInfo" class="row{if !$clientsdetails.cclastfour || $ccinfo eq "new"} hidden{/if}">
					                <div class="col-sm-12">
					                    <div class="form-group prepend-icon">
					                        <label for="inputCardCVV" class="field-icon">
					                            <i class="fa fa-barcode"></i>
					                        </label>
					                        <input type="tel" name="cccvvexisting" id="inputCardCVV" class="field" placeholder="{$LANG.orderForm.cvv}" autocomplete="cc-cvc">
					                    </div>
					                </div>
					            </div>
					        </div>
					
					        {if $shownotesfield}
					
					            <div class="sub-heading">
					                <span>{$LANG.orderForm.additionalNotes}</span>
					            </div>
					
					            <div class="row">
					                <div class="col-sm-12">
					                    <div class="form-group">
					                        <textarea name="notes" class="field" rows="4" placeholder="{$LANG.ordernotesdescription}">{$orderNotes}</textarea>
					                    </div>
					                </div>
					            </div>
					
					        {/if}
						</div>
					</div>
				
				    <div class="alert alert-warning checkout-security-msg">
				        <i class="fa fa-lock"></i>
				        {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
				    </div>
				    
				</div>
				<div class="col-sm-4 check-side" id="scrollingPanelContainer">
					<div id="orderSummary">
					    <div class="header-lined">
					        <h1>{$LANG.summary}</h1>
					    </div>
	                    
	                    <div class="view-cart-items">
	
	                        {foreach $products as $num => $product}
	                            <div class="item">
	                                <span class="item-title">
	                                    {$product.productinfo.name}
	                                </span>
	                                <span class="item-group">
	                                    {$product.productinfo.groupname}
	                                </span>
	                                {if $product.domain}
	                                    <span class="item-domain">
	                                        {$product.domain}
	                                    </span>
	                                {/if}
	                                {if $product.configoptions}
	                                    <small>
	                                    {foreach key=confnum item=configoption from=$product.configoptions}
	                                        &nbsp;&raquo; {$configoption.name}: {if $configoption.type eq 1 || $configoption.type eq 2}{$configoption.option}{elseif $configoption.type eq 3}{if $configoption.qty}{$configoption.option}{else}{$LANG.no}{/if}{elseif $configoption.type eq 4}{$configoption.qty} x {$configoption.option}{/if}<br />
	                                    {/foreach}
	                                    </small>
	                                {/if}
	                            </div>
	                            {foreach key=addonnum item=addon from=$product.addons}
	                                <div class="item">
	                                    <div class="row">
	                                        <div class="col-sm-7">
	                                            <span class="item-title">
	                                                {$addon.name}
	                                            </span>
	                                            <span class="item-group">
	                                                {$LANG.orderaddon}
	                                            </span>
	                                            {if $addon.setup}
	                                                <span class="item-setup">
	                                                    {$addon.setup} {$LANG.ordersetupfee}
	                                                </span>
	                                            {/if}
	                                        </div>
	                                        <div class="col-sm-4 item-price">
	                                            <span>{$addon.totaltoday}</span>
	                                            <span class="cycle">{$addon.billingcyclefriendly}</span>
	                                        </div>
	                                    </div>
	                                </div>
	                            {/foreach}
	                        {/foreach}
	
	                        {foreach $addons as $num => $addon}
	                            <div class="item">
	                                <span class="item-title">
	                                    {$addon.name}
	                                </span>
	                                <span class="item-group">
	                                    {$addon.productname}
	                                </span>
	                                {if $addon.domainname}
	                                    <span class="item-domain">
	                                        {$addon.domainname}
	                                    </span>
	                                {/if}
	                                {if $addon.setup}
	                                    <span class="item-setup">
	                                        {$addon.setup} {$LANG.ordersetupfee}
	                                    </span>
	                                {/if}
	                            </div>
	                        {/foreach}
	
	                        {foreach $domains as $num => $domain}
	                            <div class="item">
	                                <span class="item-title">
	                                    {if $domain.type eq "register"}{$LANG.orderdomainregistration}{else}{$LANG.orderdomaintransfer}{/if}
	                                </span>
	                                {if $domain.domain}
	                                    <span class="item-domain">
	                                        {$domain.domain}
	                                    </span>
	                                {/if}
	                                {if $domain.dnsmanagement}&nbsp;&raquo; {$LANG.domaindnsmanagement}<br />{/if}
	                                {if $domain.emailforwarding}&nbsp;&raquo; {$LANG.domainemailforwarding}<br />{/if}
	                                {if $domain.idprotection}&nbsp;&raquo; {$LANG.domainidprotection}<br />{/if}
	                            </div>
	                        {/foreach}
	
	                        {foreach key=num item=domain from=$renewals}
	                            <div class="item">
	                                <span class="item-title">
	                                    {$LANG.domainrenewal}
	                                </span>
	                                <span class="item-domain">
	                                    {$domain.domain}
	                                </span>
	                                {if $domain.dnsmanagement}&nbsp;&raquo; {$LANG.domaindnsmanagement}<br />{/if}
	                                {if $domain.emailforwarding}&nbsp;&raquo; {$LANG.domainemailforwarding}<br />{/if}
	                                {if $domain.idprotection}&nbsp;&raquo; {$LANG.domainidprotection}<br />{/if}
	                            </div>
	                        {/foreach}
	
	                    </div>
	                    
	                    <div class="subtotal">
		                	<span class="pull-left">
		                	{$LANG.ordersubtotal}
		                	</span>
		                	<span class="pull-right">
								{$subtotal}
		                	</span>
	                    </div>
					
				        <div class="total">
				            <strong>{$total}</strong>
				        </div>
					</div>
				</div>
				<div class="col-sm-12">
			        <div class="text-right check-btm">
				        <a href="javascript:;" onclick="javascript:history.go(-1);" class="btn btn-default btn-check pull-left">
					        <i class="fa fa-angle-double-left" aria-hidden="true"></i> {$LANG.goback}
					    </a>
			            {if $accepttos}
			                <p class="tos">
			                    <label class="checkbox-inline">
			                        <input type="checkbox" name="accepttos" id="accepttos" />
			                        &nbsp;
			                        {$LANG.ordertosagreement}
			                        <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a>
			                    </label>
			                </p>
			            {/if}
			
			            <button type="submit" id="btnCompleteOrder" class="btn btn-success btn-check"{if $cartitems==0} disabled="disabled"{/if} onclick="this.value='{$LANG.pleasewait}'">
			                {$LANG.completeorder}
			                &nbsp;<i class="fa fa-arrow-circle-right"></i>
			            </button>
			        </div>
				</div>
			</div>
			</form>
		</div>
		
		<script type="text/javascript" src="{$BASE_PATH_JS}/jquery.payment.js"></script>
	</div>
</section>
