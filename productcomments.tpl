{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author PrestaShop SA <contact@prestashop.com>
  * @copyright 2007-2016 PrestaShop SA
  * @license http://opensource.org/licenses/afl-3.0.php Academic Free License (AFL 3.0)
  * International Registered Trademark & Property of PrestaShop SA
  *
  * MODIFIED BY MYPRESTA.EU FOR PRESTASHOP 1.7 PURPOSES !
  *
  *}

  <script type="text/javascript">
  var productcomments_controller_url = '{$productcomments_controller_url nofilter}';
  var confirm_report_message = '{l s='Are you sure that you want to report this comment ? ' mod='productcomments ' js=1}';
  var secure_key = '{$secure_key}';
  var productcomments_url_rewrite = '{$productcomments_url_rewriting_activated}';
  var productcomment_added = '{l s='Your comment has been added!' mod='productcomments ' js=1}';
  var productcomment_added_moderation = '{l s='Your comment has been submitted and will be available once approved by a moderator.' mod='productcomments ' js=1}';
  var productcomment_title = '{l s='New comment ' mod='productcomments ' js=1}';
  var productcomment_ok = '{l s='OK ' mod='productcomments ' js=1}';
  var moderation_active = true;
  </script>
  {if $comments}
  <div id="productCommentsBlock" class="row mt-3">
    <span class="col-12" style="font-size:15px;font-weight:bold;color:#777777;font-family:Helvetica, Tahoma, sans-serif, Arial;">Beoordelingen voor dit product</span>
      <div id="product_comments_block_tab" class="col-12 pl-0 pr-0">
        {foreach from=$comments item=comment}
        {if $comment.content}
        <div class="comment clearfix row" itemprop="review" itemscope itemtype="https://schema.org/Review">
<div class="col-2">
      <table class="comment-icon w-100 h-100 text-center">
        <tr>
          <td class="valign-middle">
            <i class="fas fa-comment fa-4x"></i>
          </td>
        </tr>
      </table>
</div>
<div class="col-10">
  <div class="row">
            <div class="comment_author_infos col-8 pl-0">
              <strong class="h5 text-dark" itemprop="author">{$comment.customer_name|escape:'html':'UTF-8'}</strong> <em>({$comment.date_add|escape:'html':'UTF-8'|date_format:"d M Y"})</em>
              <meta itemprop="datePublished" content="{$comment.date_add|escape:'html':'UTF-8'|date_format:"d-m-Y H:m"}" />
            </div>
            <div class="star_content clearfix col-4" itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating">
              {section name="i" start=0 loop=5 step=1}
              {if $comment.grade le $smarty.section.i.index}
              <div class="star"></div>
              {else}
              <div class="star star_on"></div>
              {/if}
              {/section}
              <meta itemprop="worstRating" content="0" />
              <meta itemprop="ratingValue" content="{$comment.grade}" />
              <meta itemprop="bestRating" content="5" />
          </div>
          <div class="comment_details w-100">
            <div class="w-100 text-dark">
            <h6 class="title_block w-100 p-0 m-0 mt-2" itemprop="name">{$comment.title}</h6>
            <p itemprop="reviewBody" class="w-100">{if !empty($comment.content)}{$comment.content|escape:'html':'UTF-8'|nl2br nofilter}{else}Voor deze beoordeling is geen bericht geschreven{/if}</p>
            </div>
{*             <ul class="list-unstyled w-100">
              {if isset($comment.total_advice) && $comment.total_advice > 0}
              <li>{l s='%1$d out of %2$d people found this review useful.' sprintf=[$comment.total_useful,$comment.total_advice] mod='productcomments'}</li>
              {/if}
              {if isset($logged) && $logged}
              {if !$comment.customer_advice}
              <li>{l s='Was this comment useful to you?' mod='productcomments'}
                <button class="usefulness_btn btn btn-sm btn-link text-decoration-none" data-is-usefull="1" data-id-product-comment="{$comment.id_product_comment}">{l s='yes' mod='productcomments'}</button>
                <button class="usefulness_btn btn btn-sm btn-link text-decoration-none" data-is-usefull="0" data-id-product-comment="{$comment.id_product_comment}">{l s='no' mod='productcomments'}</button>
              </li>
              {/if}
              {if !$comment.customer_report}
              <li><span class="report_btn" data-id-product-comment="{$comment.id_product_comment}">{l s='Report abuse' mod='productcomments'}</span></li>
              {/if}
              {/if}
            </ul> *}
            {hook::exec('displayProductComment', $comment) nofilter}
          </div>
        </div>
        </div>
</div>

        {/if}
        {/foreach}
      </div>
          <div class="col-12">
            <input type="hidden" id="current-reviews-list-index" value="1" data-per-list="5">
            <button id="showMoreComments" class="btn btn-ouline-dark w-100">Toon meer beoordelingen</button>
          </div>
        {else}
                <div class="d-none" itemprop="review" itemscope itemtype="https://schema.org/Review">
                  <span class="d-none" itemprop="author">null</span>
                </div>
        {/if}



















    <div class="modal" id="productCommentsModal" tabindex="-1" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="saw-modal">
      <div class="modal-dialog row" role="document">
        <div class="modal-content col-12">
          <div class="modal-header row">
            <h5 class="modal-title">{l s='Write your review' mod='productcomments'}</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body row">
            <div id="new_comment_form_ok" class="alert alert-success" style="display:none;padding:15px 25px"></div>
            {if isset($productcomments_product) && $productcomments_product}
              <div id="new_comment_form" class="row">
                  {if isset($productcomments_product) && $productcomments_product}
                  <div class="product clearfix col-12">
                    <div class="product_desc">
                      <p class="product_name mb-0 p-0"><strong>{if isset($productcomments_product->name)}{$productcomments_product->name}{elseif isset($productcomments_product.name)}{$productcomments_product.name}{/if}</strong></p>
                      {if isset($productcomments_product->description_short)}{$productcomments_product->description_short nofilter}{elseif isset($productcomments_product.description_short)}{$productcomments_product.description_short nofilter}{/if}
                    </div>
                  </div>
                  {/if}

            <div class="new_comment_form_content col-12">
                <div id="new_comment_form_error" class="error w-100" style="display:none;padding:15px 25px">
                    <ul></ul>
                </div>
            <form id="id_new_comment_form" action="#">
              {if $criterions|@count > 0}
              <ul id="criterions_list" class="list-unstyled w-100">
                {foreach from=$criterions item='criterion'}
                <li class="row">
                  <label class="w-auto">Uw score</label>
                  <div class="star_content col">
                    <input class="star" type="radio" name="criterion[{$criterion.id_product_comment_criterion|round}]" value="1">
                    <input class="star" type="radio" name="criterion[{$criterion.id_product_comment_criterion|round}]" value="2">
                    <input class="star" type="radio" name="criterion[{$criterion.id_product_comment_criterion|round}]" value="3">
                    <input class="star" type="radio" name="criterion[{$criterion.id_product_comment_criterion|round}]" value="4">
                    <input class="star" type="radio" name="criterion[{$criterion.id_product_comment_criterion|round}]" value="5" checked="checked">
                  </div>
                  <div class="clearfix col-12"></div>
                </li>
                {/foreach}
              </ul>
              {/if}
              <div class="form-group mt-2">
              <label for="comment_title">{l s='Title for your review' mod='productcomments'}<sup class="required">*</sup></label>
              <input id="comment_title" class="form-control" name="title" type="text" value="" />
              </div>
              <div class="form-group mt-2">
                  <label for="content">{l s='Your review' mod='productcomments'}</label>
                  <textarea id="content" class="form-control" name="content"></textarea>
              </div>
              {if $allow_guests == true && !$logged}
              <div class="form-group">
                  <label>{l s='Your name' mod='productcomments'}<sup class="required">*</sup></label>
                  <input id="commentCustomerName" name="customer_name" type="text" value="" />
              </div>
              {/if}
                <input id="id_product_comment_send" name="id_product" type="hidden" value='{$id_product_comment_form}' />
                <p class="col-12 required"><sup>*</sup> {l s='Required fields' mod='productcomments'}</p>
          </div>
          <div class="modal-footer pt-2 col-12">
            <div class="w-100">
             <div id="new_comment_form_footer_done" class="col-12" style="display:none;">
                <a href="#" class="btn btn-secondary btn-dark float-right " data-dismiss="modal">{l s='Close' mod='productcomments'}</a>
            </div>
             <div id="new_comment_form_footer" class="col-12">
                <div class="row">
                  {if $PRODUCT_COMMENTS_GDPR == 1}
                    <div class="form-check col">
                      {literal}
                          <input class="form-check-input" onchange="if($(this).is(':checked')){$('#submitNewMessage').removeClass('gdpr_disabled'); $('#submitNewMessage').removeAttr('disabled'); rebindClickButton();}else{$('#submitNewMessage').addClass('gdpr_disabled'); $('#submitNewMessage').off('click'); $('#submitNewMessage').attr('disabled', 1); }" id="gdpr_checkbox" type="checkbox">
                      {/literal}
                    <label class="form-check-label" for="gdpr_checkbox">
                      {l s='Ik accepteer de' mod='productcomments'} <a target="_blank" href="{$link->getCmsLink($PRODUCT_COMMENTS_GDPRCMS)}">{l s='privacy voorwaarden' mod='productcomments'}</a>
                    </label>
                        </div>
                      {/if}
                  <a href="#" class="btn btn-secondary btn-dark float-right " data-dismiss="modal">{l s='Cancel' mod='productcomments'}</a>
                  <button {if $PRODUCT_COMMENTS_GDPR==1}disabled{/if} class="float-right btn btn-secondary btn-success {if $PRODUCT_COMMENTS_GDPR == 1}gdpr_disabled{/if}" id="submitNewMessage" name="submitMessage" data-dismiss="modal" type="submit">{l s='Send' mod='productcomments'}</button>&nbsp;
                </div>
                <div class="clearfix"></div>
              </div>
            </div>
            </div>
            </form><!-- /end new_comment_form_content -->
          </div>
            </div>
            {/if}
        </div>
      </div>
    </div>
  </div>
