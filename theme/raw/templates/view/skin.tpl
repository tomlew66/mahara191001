{if !$saved}
<div class="alert alert-warning">
    <span class="icon icon-lg icon-exclamation-triangle left" role="presentation" aria-hidden="true"></span>
    {str tag=notsavedyet section=skin}
</div>
{/if}

{if $incompatible}
<div class="alert alert-danger">
    <span class="icon icon-ban" role="presentation" aria-hidden="true"></span>
    {$incompatible}
</div>
{/if}

<div class="row view-container">
    <div class="col-md-3">
        <div>
            <h2>
                {str tag=currentskin section=skin}
            </h2>

            <div>
                {if $currentskin}
                    <img class="thumbnail" src="{$WWWROOT}skin/thumb.php?id={$currentskin}" alt="{$currenttitle}">
                {else}
                    <img class="thumbnail" src="{$WWWROOT}skin/no-thumb.png" alt="{$currenttitle}">
                {/if}
                <ul class="metadata unstyled">
                    {if $currentskin}
                        <li class="title">
                            <span class="h4 text-midtone">{$currenttitle}</span>
                        </li>
                    {/if}
                    {if $currentmetadata}
                        <li class="metadisplayname">
                            <strong>{str tag=displayname section=skin}: </strong> {$currentmetadata.displayname|clean_html|safe}
                        </li>
                        {if $currentmetadata.description}
                        <li class="metadescription">
                            <strong>{str tag=description section=skin}: </strong>{$currentmetadata.description|clean_html|safe}
                        </li>
                        {/if}
                        <li class="metacreationdate">
                            <strong>{str tag=creationdate section=skin}: </strong> {$currentmetadata.ctime}
                        </li>
                        <li class="metamodifieddate">
                            <strong>{str tag=modifieddate section=skin}: </strong> {$currentmetadata.mtime}
                        </li>
                     {/if}
                </ul>
            </div>

            <div class="has-form">
                <div class="pull-left">
                    {$form|safe}
                </div>

                {if $defaultskin->id != $currentskin}
                <span class="defaultskin">
                    <a onClick = "change_skin({$viewid}, 0)" class="btn btn-default btn-sm">
                        <span class="icon icon-ban text-danger left" role="presentation" aria-hidden="true"></span>
                        {$defaultskin->title|safe}
                    </a>
                </span>
                {/if}
            </div>
        </div>

        <div class="manage-skins-btn">
            <a class="btn btn-default" href="{$WWWROOT}skin/index.php">
              <span class="icon icon-magic icon-flip-horizontal icon-lg left" role="presentation" aria-hidden="true"></span>
              {str tag=manageskins section=skin}
            </a>
        </div>

    </div>
    <div class="col-md-9">
        <div class="collapsible-group skins">
            <div class="panel panel-default collapsible collapsible-group first">
                <h3 class="panel-heading">
                    <a href="#userskins" data-toggle="collapse" aria-expanded="false" aria-controls="#userskins">
                        {str tag=userskins section=skin}
                        <span class="icon icon-chevron-down collapse-indicator pull-right" role="presentation" aria-hidden="true"></span>
                    </a>
                </h3>
                <div id="userskins" class="panel-body collapse in">
                    {foreach from=$userskins item=skin}
                        <div class="skin">
                            <a onClick = "change_skin({$viewid}, {$skin->id})">
                                <img src="{$WWWROOT}skin/thumb.php?id={$skin->id}" class="thumbnail" width="180" alt="{$skin->title}"/>
                                 <div class="lead text-center text-small">
                                {$skin->title}
                                </div>
                            </a>
                        </div>
                    {/foreach}
                </div>
            </div>
            {if $favorskins}
            <div class="panel panel-default collapsible collapsible-group">
                <h3 class="panel-heading">
                    <a href="#favorskins" data-toggle="collapse" aria-expanded="false" aria-controls="#favorskins" class="collapsed">
                        {str tag=favoriteskins section=skin}
                        <span class="icon icon-chevron-down collapse-indicator pull-right" role="presentation" aria-hidden="true"></span>
                    </a>
                </h3>
                <div id="favorskins" class="panel-body collapse">
                    {foreach from=$favorskins item=skin}
                        <div class="skin">
                            <a onClick = "change_skin({$viewid}, {$skin->id})">
                                <img src="{$WWWROOT}skin/thumb.php?id={$skin->id}" class="thumbnail" width="180" alt="{$skin->title}"/>
                                 <div class="lead text-center text-small">
                                {$skin->title}
                                </div>
                            </a>
                        </div>
                    {/foreach}
                </div>
            </div>
            {/if}
            <div class="panel panel-default collapsible collapsible-group last">
                <h3 class="panel-heading">
                    <a href="#siteskins" data-toggle="collapse" aria-expanded="false" aria-controls="#siteskins" class="collapsed">
                        {str tag=siteskins section=skin}
                        <span class="icon icon-chevron-down collapse-indicator pull-right" role="presentation" aria-hidden="true"></span>
                    </a>
                </h3>
                <div id="siteskins" class="panel-body no-footer collapse">
                    {foreach from=$siteskins item=skin}
                        <div class="skin">
                            <a onClick="change_skin({$viewid}, {$skin->id})">
                                <img src="{$WWWROOT}skin/thumb.php?id={$skin->id}" class="thumbnail" width="180" alt="{$skin->title}"/>
                                 <div class="lead text-center text-small">
                                {$skin->title}
                                </div>
                            </a>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>
