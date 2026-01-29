//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery3
//= require popper
//= require bootstrap
//= require moment
//= require jquery.richtext

//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

//= require lottie.min

// *** layout sb-admin
//= require sb-admin-2

//= require "nouislider.min"

//= require application/namespace
//= require application/util

// *** Select input with multiple value with search
//= require bootstrap-select
//= require common/select_picker

// *** Select date input field
//= require tempusdominus-bootstrap-4.js
//= require common/datetime_picker

// *** Scheduling
//= require recurring_select
//= require common/select_recurring_translation

// *** Daterange picker
//= require daterangepicker
//= require common/daterange_locale
//= require common/daterange_picker

//= require common/topbar
//= require common/timeago
//= require common/country
//= require common/sidebar
//= require common/confirm_modal
//= require common/tag_list
//= require common/toggle_advance_search

// *** For building questionnaire skip logic
//= require common/skip_logic_constant
//= require common/question_type
//= require common/skip_logic
//= require common/criteria

// *** Questionnaire form
//= require common/form
//= require common/audio

// *** Sort order
//= require jquery-sortable
//= require tagify.min

// *** Form wizard
//= require common/wizard_form

// *** All pages
//= require accounts/index
//= require category_images
//= require categories
//= require departures/new
//= require forms/index
//= require forms/new
//= require notifications/index
//= require notifications/new
//= require institutions/new
//= require videos/form
//= require survey_form
//= require telegram_bot
//= require users/index
//= require deletions/show

$(document).on("ready turbolinks:load", () => {
  MW.Common.Topbar.init();
  MW.Common.Timeago.init();
  MW.Common.SelectPicker.init();
  MW.Common.DatetimePicker.init();
  MW.Common.Sidebar.init();
  MW.Common.ConfirmModal.init();
  MW.Common.WizardForm.init();
  MW.Common.DaterangePicker.init();
  MW.Common.toggleAdvanceSearch.init();

  $("[data-toggle='tooltip']").tooltip();

  let currentPage = MW.Util.getCurrentPage();
  !!MW[currentPage] && MW[currentPage].init();
});
