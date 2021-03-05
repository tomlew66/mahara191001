{include file="header.tpl"}

{if $collection}
    {include file=collectionnav.tpl}
{/if}

{if $notrudeform}
    <div class="alert alert-danger">
    {$notrudeform|safe}
    </div>
{elseif $objector}
    <div class="alert alert-danger">{str tag=objectionablematerialreported}</div>
{/if}
{if $userisowner && $objectedpage}
    <div class="alert alert-danger">
        {if $objectionreplied}
            {str tag=objectionablematerialreportreplied}
        {else}
            {str tag=objectionablematerialreportedowner}
            <br><br>
            {str tag=objectionablematerialreportedreply}
        {/if}
        <div class="form-group">
        <a id="review_link" class="btn btn-default" href="#" data-toggle="modal" data-target="#review-form">
            <span class="icon icon-lg icon-flag text-danger left" role="presentation" aria-hidden="true"></span>
            {str tag=objectionreview}
        </a>
        </div>
    </div>
{/if}

{if $maintitle}
<h1 id="viewh1" class="page-header">
    {if $title}
        <span class="subsection-heading">{$title|safe}</span>
    {else}
        <span class="section-heading">{$maintitle|safe}</span>
    {/if}
</h1>
{/if}

<div class="btn-group btn-group-top">


    {if $editurl}{strip}
        <a title="{str tag=editthisview section=view}" href="{$editurl}" class="btn btn-default">
            <span class="icon icon-pencil icon-lg left" role="presentation" aria-hidden="true"></span>
            {str tag=editthisview section=view}
        </a>
    {/strip}{/if}

    {if $copyurl}{strip}
        {if $downloadurl}
            <a id="downloadview-button" title="{str tag=copythisview section=view}" href="{$downloadurl}" class="btn btn-default">
        {else}
            <a id="copyview-button" title="{str tag=copythisview section=view}" href="{$copyurl}" class="btn btn-default">
        {/if}
        <span class="icon icon-files-o icon-lg left" role="presentation" aria-hidden="true"></span>
        {str tag=copy section=mahara}
    </a>
    {/strip}{/if}

    {if $mnethost}
    <a href="{$mnethost.url}" class="btn btn-default">
        <span class="icon icon-long-arrow-right icon-lg left" role="presentation" aria-hidden="true"></span>
        {str tag=backto arg1=$mnethost.name}
    </a>
    {/if}

    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
        <span class="icon icon-ellipsis-h icon-lg" role="presentation" aria-hidden="true"></span>
        <span class="sr-only">{str tag="more..."}</span>
    </button>
    <ul class="dropdown-menu dropdown-menu-right" role="menu">
        <li>
            <a title="{str tag=print section=view}" id="print_link" href="#" onclick="window.print(); return false;">
                <span class="icon icon-print left" role="presentation" aria-hidden="true"></span>
                {str tag=print section=view}
            </a>
        </li>
        {if $LOGGEDIN}
            {if !$userisowner}
            <li>
                <a id="toggle_watchlist_link" class="watchlist" href="">
                    {if $viewbeingwatched}
                   <span class="icon icon-eye-slash left" role="presentation" aria-hidden="true"></span>
                    {str tag=removefromwatchlist section=view}
                    {else}
                    <span class="icon icon-eye left" role="presentation" aria-hidden="true"></span>
                    {str tag=addtowatchlist section=view}
                   {/if}
                </a>
            </li>
            <li>
                {if $objector}
                    <span class="nolink">
                        <span class="icon icon-lg icon-flag text-danger left" role="presentation" aria-hidden="true"></span>
                        {str tag=objectionablematerialreported}
                    </span>
                {else}
                    <a id="objection_link" href="#" data-toggle="modal" data-target="#report-form">
                        <span class="icon icon-lg icon-flag text-danger left" role="presentation" aria-hidden="true"></span>
                        {str tag=reportobjectionablematerial}
                    </a>
                {/if}
            </li>
            {/if}
            {if $userisowner && $objectedpage}
            <li>
                <a id="review_link" href="#" data-toggle="modal" data-target="#review-form">
                    <span class="icon icon-lg icon-flag text-success left" role="presentation" aria-hidden="true"></span>
                    {str tag=objectionreview}
                </a>
            </li>
            {/if}
            {if $userisowner || $canremove}
            <li>
                <a href="{$WWWROOT}view/delete.php?id={$viewid}" title="{str tag=deletethisview section=view}">
                    <span class="icon icon-lg icon-trash text-danger" role="presentation" aria-hidden="true"></span>
                    <span class="sr-only">{str(tag=deletespecific arg1=$maintitle)|escape:html|safe}</span>
                    {str tag=deletethisview section=view}
                </a>
            </li>
            {/if}
        {/if}
        {if $versionurl}
            <li>
              <a href="{$versionurl}">
                  <span class="icon icon-code-fork icon-lg left" role="presentation" aria-hidden="true"></span>
                  <span class="sr-only">{str(tag=timelinespecific section=view arg1=$maintitle)|escape:html|safe}</span>
                  {str tag=timeline section=view}
              </a>
            </li>
        {/if}
        {if $userisowner}
            <li>
              <a href="{$createversionurl}">
                  <span class="icon icon-save icon-lg left" role="presentation" aria-hidden="true"></span>
                  <span class="sr-only">{str(tag=savetimelinespecific section=view arg1=$maintitle)|escape:html|safe}</span>
                  {str tag=savetimeline section=view}
              </a>
            </li>
        {/if}
    </ul>
</div>
<div class="btn-group-top-below">
    {if $toolbarhtml}
        {$toolbarhtml|safe}
    {/if}
</div>

<div class="with-heading text-small">
    {include file=author.tpl}

    {if $alltags}
    <div class="tags">
        <strong>{str tag=tags}:</strong>
        {list_tags owner=$owner tags=$alltags view=$viewid}
        {if $moretags}
            <a href="#" class="moretags">
            <span class="icon icon-ellipsis-h" role="presentation" aria-hidden="true"></span>
            <span class="sr-only">{str tag="more..."}</span>
            </a>
        {/if}
    </div>
    {/if}
</div>

<div id="view-description" class="view-description {if $toolbarhtml}with-toolbar{/if}">
    {$viewdescription|clean_html|safe}
</div>

{if $viewinstructions}
    <div id="viewinstructions" class="pageinstructions view-instructions last form-group collapsible-group small-group {if $toolbarhtml}with-toolbar{/if}">
    <fieldset  class="pieform-fieldset collapsible collapsible-small">
        <legend>
            <h4>
                <a href="#viewinstructions-dropdown" data-toggle="collapse" aria-expanded="false" aria-controls="viewinstructions-dropdown" class="collapsed">
                    {str tag='instructions' section='view'}
                    <span class="icon icon-chevron-down collapse-indicator right text-inline"></span>
                </a>
            </h4>
        </legend>
        <div class="viewinstructions fieldset-body collapse" id="viewinstructions-dropdown">
            {$viewinstructions|clean_html|safe}
        </div>
    </fieldset>
    </div>
{/if}

<div id="view" class="view-container">
    <div id="bottom-pane">
        <div id="column-container" class="user-page-content">
            {if $viewcontent}
                {$viewcontent|safe}
            {else}
                <div class="alert alert-info">
                    <span class="icon icon-lg icon-info-circle left" role="presentation" aria-hidden="true"></span>
                    {str tag=nopeerassessmentrequired section=artefact.peerassessment}
                </div>
            {/if}
        </div>
    </div>
    <div class="viewfooter view-container">
        {if $releaseform}
        <div class="releaseviewform alert alert-warning clearfix">
            {$releaseform|safe}
        </div>
        {/if}

        {if $view_group_submission_form}
        <div class="submissionform alert alert-default">
            {$view_group_submission_form|safe}
        </div>
        {/if}

        {if $ltisubmissionform}
        <div class="submissionform alert alert-default">
            {$ltisubmissionform|safe}
        </div>
        {/if}

        {if $feedback->position eq 'base'}
        <div class="comment-container">
            {if $feedback->count || $enablecomments}
            <h3 class="title">
                {str tag="Comments" section="artefact.comment"}
            </h3>
            {if $feedback->count == 0}
            <hr />
            {/if}
            {* Do not change the id because it is used by paginator.js *}
            <div id="feedbacktable" class="feedbacktable js-feedbackbase fullwidth">
                {$feedback->tablerows|safe}
            </div>
            {$feedback->pagination|safe}
            {/if}

            {if $enablecomments}
                {include file="view/viewmenu.tpl"}
            {/if}
        </div>
        {/if}

        {if $feedback->position eq 'blockinstance' && $enablecomments}
        <div class="feedback modal modal-docked" id="feedback-form">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal-docked" aria-label="{str tag=Close}">
                            <span class="times">&times;</span>
                            <span class="sr-only">{str tag=Close}</span>
                        </button>
                        <h4 class="modal-title">
                            <span class="icon icon-lg icon-comments left" role="presentation" aria-hidden="true"></span>
                            {str tag=addcomment section=artefact.comment}
                        </h4>
                    </div>
                    <div class="modal-body">
                        {$addfeedbackform|safe}
                    </div>
                </div>
            </div>
        </div>
        {/if}

        {if $LOGGEDIN}
        <div class="modal fade" id="report-form">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="{str tag=Close}"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">
                            <span class="icon icon-lg icon-flag text-danger left" role="presentation" aria-hidden="true"></span>
                            {str tag=reportobjectionablematerial}
                        </h4>
                    </div>
                    <div class="modal-body">
                        {$objectionform|safe}
                    </div>
                </div>
            </div>
        </div>
        {/if}
        {if $userisowner}
        <div class="modal fade" id="review-form">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">
                            <span class="icon icon-lg icon-flag text-success left" role="presentation" aria-hidden="true"></span>
                            {str tag=objectionreview}
                        </h4>
                    </div>
                    <div class="modal-body">
                        {$reviewform|safe}
                    </div>
                </div>
            </div>
        </div>
        {/if}
        <div class="modal fade" id="copyview-form">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="{str tag=Close}"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">
                            <span class="icon icon-lg icon-flag text-danger left" role="presentation" aria-hidden="true"></span>
                            {str tag=confirmcopytitle section=view}
                        </h4>
                    </div>
                    <div class="modal-body">
                        <p>{str tag=confirmcopydesc section=view}</p>
                        <div class="btn-group">
                            <button id="copy-collection-button" type="button" class="btn btn-default"><span class="icon icon-folder-open" role="presentation" aria-hidden="true"></span> {str tag=Collection section=collection}</button>
                            <button id="copy-view-button" type="button" class="btn btn-default"><span class="icon icon-file-text " role="presentation" aria-hidden="true"></span> {str tag=view}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="metadata text-right">
    {$lastupdatedstr}{if $visitstring}; {$visitstring}{/if}
</div>

{if $stillrudeform}
    {include file=objectionreview.tpl}
{/if}

{include file="footer.tpl"}
