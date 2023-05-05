$(function () {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enable_2") {
            document.getElementById('window_2').style.display = event.data.isVisible;
		}
    });
    
    $("#Bezar").click(function () {
        $.post('http://illegalshop/exit', JSON.stringify({}));
        return

    });

    dragElement(document.getElementById("window_2"));

    $("#Open").click(function () {
        $.post('http://illegalshop/targyeladas', JSON.stringify({}));
        return
    });
    dragElement(document.getElementById("window_2"));

    $("#Buy").click(function () {
      $.post('http://illegalshop/sellmedal', JSON.stringify({}));
      return
  });
  dragElement(document.getElementById("window_2"));

function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "window_2")) {
   
    document.getElementById(elmnt.id + "window_2").onmousedown = dragMouseDown;
  } else {
 
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;

    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
   
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
 
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    
    document.onmouseup = null;
    document.onmousemove = null;
  }
}

});