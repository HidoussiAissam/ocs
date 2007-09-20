{**
 * siteMap.tpl
 *
 * Copyright (c) 2000-2007 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Conference / Site Map.
 *
 * TODO: Show the site map.
 *
 * $Id$
 *}
{assign var="pageTitle" value="about.siteMap"}
{include file="common/header.tpl"}

<ul class="plain">
<li>
	<a href="{url conference="index" page="index" op="index"}">{translate key="navigation.home"}</a><br/>
	<ul class="plain">
	{if $conferences|@count>1 && !$currentConference}
		{foreach from=$conferences item=conference}
			<li><a href="{url conference=`$conference->getPath()` page="about" op="siteMap"}">{$conference->getConferenceTitle()|escape}</a></li>
		{/foreach}
	{else}
		{if $conferences|@count==1}
			{assign var=currentConference value=$conferences[0]}
		{else}
			<li><a href="{url conference="index" page="about" op="siteMap"}">{translate key="conference.conferences"}</a><br/>
			<ul class="plain">
			{assign var=onlyOneConference value=1}
		{/if}

		<li><a href="{url conference=`$currentConference->getPath()`}">{$currentConference->getConferenceTitle()|escape}</a><br/>
			<ul class="plain">
				<li><a href="{url conference=`$currentConference->getPath()` page="about"}">{translate key="navigation.about"}</a></li>
				<li>
					{if $isUserLoggedIn}
						<li><a href="{url conference=`$currentConference->getPath()` page="user"}">{translate key="navigation.userHome"}</a><br/>
							<ul class="plain">
								{assign var=currentConferenceId value=$currentConference->getConferenceId()}
								{foreach from=$rolesByConference[$currentConferenceId] item=role}
									{translate|assign:"roleName" key=$role->getRoleName()}
									<li><a href="{url conference=`$currentConference->getPath()` page=`$role->getRolePath()`}">{$roleName}</a></li>
								{/foreach}
							</ul>
						</li>
					{else}
						<li><a href="{url conference=`$currentConference->getPath()` page="login"}">{translate key="navigation.login"}</a></li>
						<li><a href="{url conference=`$currentConference->getPath()` page="account"}">{translate key="navigation.account"}</a></li>
					{/if}
					<li><a href="{url conference=`$currentConference->getPath()` page="search"}">{translate key="navigation.search"}</a><br />
						<ul class="plain">
							<li><a href="{url conference=`$currentConference->getPath()` page="search" op="presenters"}">{translate key="navigation.browseByPresenter"}</a></li>
							<li><a href="{url conference=`$currentConference->getPath()` page="search" op="titles"}">{translate key="navigation.browseByTitle"}</a></li>
						</ul>
					</li>
				</li>
				{foreach from=$currentConference->getLoaclizedSetting('navItems') item=navItem}
					<li><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{url page=""}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name|escape}{/if}</a></li>
				{/foreach}
			</ul>
		</li>	
		{if $onlyOneConference}</ul></li>{/if}

	{/if}
	</ul>
</li>
{if $isSiteAdmin}
	<li><a href="{url conference="index" page=$isSiteAdmin->getRolePath()}">{translate key=$isSiteAdmin->getRoleName()}</a></li>
{/if}
<li><a href="http://pkp.sfu.ca/ojs">{translate key="common.openConferenceSystems"}</a></li>
<!-- li><a href="javascript:openHelp('{url conference="index" page="help"}')">{translate key="help.help"}</a></li -->
</ul>

{include file="common/footer.tpl"}
