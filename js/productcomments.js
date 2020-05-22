$(document).ready(function() {
    $('input.star').rating();
    $('.auto-submit-star').rating();

    url_options = '?';

    if (typeof(productcomments_url_rewrite) !== 'undefined') {
        if (productcomments_url_rewrite == '0') {
            url_options = '&';
        }
    }

    $('button.usefulness_btn').click(function() {
        var id_product_comment = $(this).data('id-product-comment');
        var is_usefull = $(this).data('is-usefull');
        var parent = $(this).parent();

        $.ajax({
            url: productcomments_controller_url + url_options + 'rand=' + new Date().getTime(),
            data: {
                id_product_comment: id_product_comment,
                action: 'comment_is_usefull',
                value: is_usefull
            },
            type: 'POST',
            headers: {
                "cache-control": "no-cache"
            },
            success: function(result) {
                parent.fadeOut('slow', function() {
                    parent.remove();
                });
            }
        });
    });

    $('span.report_btn').click(function() {
        if (confirm(confirm_report_message)) {
            var idProductComment = $(this).data('id-product-comment');
            var parent = $(this).parent();

            $.ajax({
                url: productcomments_controller_url + url_options + 'rand=' + new Date().getTime(),
                data: {
                    id_product_comment: idProductComment,
                    action: 'report_abuse'
                },
                type: 'POST',
                headers: {
                    "cache-control": "no-cache"
                },
                success: function(result) {
                    parent.fadeOut('slow', function() {
                        parent.remove();
                    });
                }
            });
        }
    });

    $('#module-productcomments-feedback ul.page-list li a').removeClass('js-search-link');
    $('#module-productcomments-feedback ul.page-list li a').off();


    $('#showMoreComments').on('click', function(event) {
        event.preventDefault();
        var page = parseInt($('#current-reviews-list-index').val()) + 1;
        var total = $('#current-reviews-list-index').attr('data-per-list');
        var id_product = $('#product_page_product_id').val();

        $.ajax({
                url: productcomments_controller_url + url_options + 'action=get_more_comments&secure_key=' + secure_key + '&rand=' + new Date().getTime(),
                type: 'GET',
                dataType: 'json',
                data: {
                    'id_product': id_product,
                    'page': page,
                    'per_list': total
                },
            })
            .done(function(e) {
                if (e.errors !== '') {
                    console.log('Error');
                    return;
                }

                $('#current-reviews-list-index').val(page);
                var html = '';
                var loggedIn = prestashop.customer.is_logged;
                console.log(loggedIn);

                for (var i = 0; i < e.result.length; i++) {
                    var comment = e.result[i];
                    var advice_usefull = '';
                    if (comment.total_advice !== undefined && parseInt(comment.total_advice) > 0 && loggedIn) {
                        advice_usefull = '<li>' + comment.total_useful + ' van de ' + comment.total_advice + ' vond deze beoordeling handig</li>';
                    }

                    var advice_buttons = '';
                    if (comment.customer_advice !== undefined && parseInt(comment.customer_advice) === 0 && loggedIn) {
                        advice_buttons = '<li>Was deze beoordeling handig voor u?'+
                                            '<button class="usefulness_btn btn btn-sm btn-link text-decoration-none" data-is-usefull="1" data-id-product-comment="${comment.id_product_comment}">Ja</button>'+
                                            '<button class="usefulness_btn btn btn-sm btn-link text-decoration-none" data-is-usefull="0" data-id-product-comment="${comment.id_product_comment}">Nee</button>'+
                                        '</li>';
                    }

                    var report_abuse = '';
                    if (!parseInt(comment.customer_report)) {

                        report_abuse = '<li>'+
                                         '<span class="report_btn" data-id-product-comment="${comment.id_product_comment}">'+
                                         'Raporteer deze opmerking'+
                                         '</span>'+
                                        '</li>';
                    }

                    var stars = 0;
                    var starsTotal = 5
                    var starsHtml = '';
                    while (starsTotal > stars) {
                        if (stars < parseInt(comment.grade)) {
                            starsHtml += '<div class="star star_on"></div>';
                        } else {
                            starsHtml += '<div class="star"></div>';
                        }

                        stars++;
                    }

                    if (comment.total_advice !== undefined && parseInt(comment.total_advice) === 0) {
                        html += '<div class="comment clearfix row" itemprop="review" itemscope itemtype="https://schema.org/Review">'+
                        '<div class="comment_author_infos col-8 pl-0">'+
                          '<strong itemprop="author">${comment.customer_name}</strong> <em>'+comment.date_add+'</em>'+
                          '<meta itemprop="datePublished" content="${comment.date_add}" />'+
                        '</div>'+
                        '<div class="star_content clearfix col-4" itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating">'+
                            starsHtml+
                          '<meta itemprop="worstRating" content="0" />'+
                          '<meta itemprop="ratingValue" content="${comment.grade}" />'+
                          '<meta itemprop="bestRating" content="5" />'+
                      '</div>'+
                      '<div class="comment_details w-100">'+
                        '<div class="w-100 p-2 text-dark">'+
                        '<h6 class="title_block w-100 p-0 m-0 mt-2" itemprop="name">'+comment.title+'</h6>'+
                        '<p itemprop="reviewBody" class="w-100">'+comment.content+'</p>'+
                        '</div>'+
                        '<ul class="list-unstyled w-100">'+
                          advice_usefull+
                          advice_buttons+
                          report_abuse+
                        '</ul>'+
                      '</div>'+
                    '</div>';
                    }
                }
                $('#product_comments_block_tab').append(html);
                $('button.usefulness_btn').click(function() {
                    var id_product_comment = $(this).data('id-product-comment');
                    var is_usefull = $(this).data('is-usefull');
                    var parent = $(this).parent();

                    $.ajax({
                        url: productcomments_controller_url + url_options + 'rand=' + new Date().getTime(),
                        data: {
                            id_product_comment: id_product_comment,
                            action: 'comment_is_usefull',
                            value: is_usefull
                        },
                        type: 'POST',
                        headers: {
                            "cache-control": "no-cache"
                        },
                        success: function(result) {
                            parent.fadeOut('slow', function() {
                                parent.remove();
                            });
                        }
                    });
                });

                $('span.report_btn').click(function() {
                    if (confirm(confirm_report_message)) {
                        var idProductComment = $(this).data('id-product-comment');
                        var parent = $(this).parent();

                        $.ajax({
                            url: productcomments_controller_url + url_options + 'rand=' + new Date().getTime(),
                            data: {
                                id_product_comment: idProductComment,
                                action: 'report_abuse'
                            },
                            type: 'POST',
                            headers: {
                                "cache-control": "no-cache"
                            },
                            success: function(result) {
                                parent.fadeOut('slow', function() {
                                    parent.remove();
                                });
                            }
                        });
                    }
                });
            })
            .fail(function(e) {
                console.log([e, "failes"]);
            });
    });

    rebindClickButton();
});

function rebindClickButton() {
    $('#submitNewMessage').off('click');
    $('#submitNewMessage').click(function(e) {
        // Kill default behaviour
        e.preventDefault();

        $.ajax({
            url: productcomments_controller_url + url_options + 'action=add_comment&secure_key=' + secure_key + '&rand=' + new Date().getTime(),
            data: $('#id_new_comment_form').serialize(),
            type: 'POST',
            headers: {
                "cache-control": "no-cache"
            },
            dataType: "json",
            success: function(data) {
                if (data.result) {
                    showCriterianModal(moderation_active ? productcomment_added_moderation : productcomment_added);
                    $('#new_comment_form').hide();
                    $('.new_comment_form_content').hide();
                    $('#new_comment_form_footer').hide();
                    $('#new_comment_form_footer_done').show();
                } else {
                    $('#new_comment_form_error ul').html('');
                    $.each(data.errors, function(index, value) {
                        $('#new_comment_form_error ul').append('<li>' + value + '</li>');
                    });
                    $('#new_comment_form_error').slideDown('slow');
                }
            }
        });
        return false;
    });
}

function showCriterianModal(msg) {
    $('#new_comment_form_ok').html(msg).show();
}

function productcommentRefreshPage() {
    window.location.reload();
}