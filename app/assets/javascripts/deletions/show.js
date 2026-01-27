MW.UsersDeletionsShow = (() => {
  return { init };

  function init() {
    initDoneAnimation();
  }

  function initDoneAnimation() {
    const doneAnimationEl = document.getElementById('doneAnimation');

    if (!doneAnimationEl) return;

    lottie.loadAnimation({
      container: doneAnimationEl,
      renderer: 'svg',
      loop: false,
      autoplay: true,
      path: $(doneAnimationEl).data('icon-url')
    });
  }
})();
