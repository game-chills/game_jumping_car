const memoryEHtmlTouches = {
  touches: [],
};

const memoryEHtmlMouse = {
  x: 0,
  y: 0,
  xc: 0,
  yc: 0,
}

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

  element.addEventListener('mousemove', (event) => {
    const rect = element.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    const xc = x / rect.width;
    const yc = y / rect.height;

    memoryEHtmlMouse.x = x;
    memoryEHtmlMouse.y = y;
    memoryEHtmlMouse.xc = xc;
    memoryEHtmlMouse.yc = yc;
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

function eHtmlTouchesGetMouse() {
  const json = {
    mouse: memoryEHtmlMouse,
  }

  return JSON.stringify(json);
}
