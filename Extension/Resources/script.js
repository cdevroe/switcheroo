(() => {
    'use strict';

    window.addEventListener('keydown', (e) => {
        if (e.target.tagName == 'INPUT' ||
            e.target.tagName == 'SELECT' ||
            e.target.tagName == 'TEXTAREA' ||
            e.target.isContentEditable) {
            return;
        }

        if (!e.altKey || !e.metaKey || e.ctrlKey) return;

        if (e.code === 'KeyS') {
            e.stopImmediatePropagation();
            safari.extension.dispatchMessage('switchProfile');
        }
    }, true);
})();
