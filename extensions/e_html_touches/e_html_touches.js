const memoryEHtmlTouches = {
  touches: [],
};

function eHtmlTouchesInit() {
  const element = document.querySelector('.gm4html5_div_class');

  element.addEventListener('touchstart', (event) => {
    const touches = event.touches;
    memoryEHtmlTouches.touches = [];
    for (let i = 0; i < touches.length; i++) {
      const touch = touches[i];
      memoryEHtmlTouches.touches.push({
        clientX: touch.clientX,
        clientY: touch.clientY,
        force: touch.force,
        identifier: touch.identifier,
        pageX: touch.pageX,
        pageY: touch.pageY,
        radiusX: touch.radiusX,
        radiusY: touch.radiusY,
        rotationAngle: touch.rotationAngle,
        screenX: touch.screenX,
        screenY: touch.screenY,
      });
    }
  });

  element.addEventListener('touchmove', (event) => {
    const touches = event.touches;
    memoryEHtmlTouches.touches = [];
    for (let i = 0; i < touches.length; i++) {
      const touch = touches[i];
      memoryEHtmlTouches.touches.push({
        clientX: touch.clientX,
        clientY: touch.clientY,
        force: touch.force,
        identifier: touch.identifier,
        pageX: touch.pageX,
        pageY: touch.pageY,
        radiusX: touch.radiusX,
        radiusY: touch.radiusY,
        rotationAngle: touch.rotationAngle,
        screenX: touch.screenX,
        screenY: touch.screenY,
      });
    }
  });

  element.addEventListener('touchend', (event) => {
    const touches = event.touches;
    memoryEHtmlTouches.touches = [];
    for (let i = 0; i < touches.length; i++) {
      const touch = touches[i];
      memoryEHtmlTouches.touches.push({
        clientX: touch.clientX,
        clientY: touch.clientY,
        force: touch.force,
        identifier: touch.identifier,
        pageX: touch.pageX,
        pageY: touch.pageY,
        radiusX: touch.radiusX,
        radiusY: touch.radiusY,
        rotationAngle: touch.rotationAngle,
        screenX: touch.screenX,
        screenY: touch.screenY,
      });
    }
  });
}

function eHtmlTouchesGet() {
  const element = document.querySelector('.gm4html5_div_class');
  const rect = element.getBoundingClientRect();

  const json = {
    crect: rect,
    ctouches: memoryEHtmlTouches.touches,
  };

  return JSON.stringify(json);
}
