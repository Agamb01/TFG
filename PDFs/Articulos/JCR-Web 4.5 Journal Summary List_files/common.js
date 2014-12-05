// display Help in new window
function show_window(url, winName) { 
    var winprops;
    var newwindow;
    var win_w = parseInt(screen.width * 0.85);
    var win_h = parseInt(screen.height * 0.70);

    winprops = 'height='+ win_h +',width='+ win_w +',top=70,left=60,toolbar=yes,menubar=yes,'+
               'resizable=yes,scrollbars=yes,status=no';
    newwindow = window.open(url, winName, winprops);

    if (window.focus) { newwindow.focus(); }

    return false;
}

// alias for show_window
function show_help(url, winName) { 
  return show_window(url, winName);
}

function submit_on_sort(sel) {
  document.getElementById('sort_order').value = sel;
  document.forms[0].submit();
}

function redirect_on_sort(uri,sel) {
  var redirect_uri = uri + "&sort_order=" + sel;
  window.location = redirect_uri;
}

function export_checkbox_selection(export_now) {
  var c_value = "";
  var export_mode = "Selection";

  for (var i=0; i < document.forms[0].ExportMode.length; i++)
  {
   if (document.forms[0].ExportMode[i].checked)
   {
         export_mode = document.forms[0].ExportMode[i].value;
   }
  }

  var row_ids_length = document.getElementsByName('row_ids').length;

  if(row_ids_length == 1)
  {
         if (document.forms[0].row_ids.checked || export_mode == 'Page')
         {
            c_value = c_value + document.forms[0].row_ids.value;
         }
  }
   
  if(row_ids_length > 1)
  {
  for (var i=0; i < row_ids_length; i++)
  {
   	var idval = document.forms[0].row_ids[i].value;
    	if (document.forms[0].row_ids[i].checked || export_mode == 'Page')
        {
           c_value = c_value + idval + ",";
   	}
  }
  }
  document.getElementById('selected_ids').value = c_value;
  if(export_now)
  {
     document.getElementById('export_now').value = 1;
  }
  if(export_mode == 'Selection' && c_value == "")
  {
         document.getElementById('export_now').value = 0;
         alert("Please select at least one record using checkboxes");
         return false;
  }
  else
  {
         document.forms[0].submit();
  }
  return true;
}

function check_all_ids()
{
   if(document.forms[0].ExportMode[1].checked)
   {
   	for (var i=0; i < document.forms[0].row_ids.length; i++)
  	{
            document.forms[0].row_ids[i].checked = true;
        }
   }
   else
   { 
	for (var i=0; i < document.forms[0].row_ids.length; i++)
        {
            document.forms[0].row_ids[i].checked = false;
        }
   }

}

// submits a form when the 'enter' key is hit.
// To simulate a image button click, pass id also.
function submit_on_enter(event, id) {
  var key;
  if (navigator.appName=="Netscape") {
    key = event.which;
  } else {
    key = window.event.keyCode;
  }
  if (key == 13) {
    if (id) {
      var button = document.getElementById(id);
      // For this to work in IE, we need to fake the X and Y coordinates of the 'click',
      //   so we will create IMAGE.x and IMAGE.y form values on the fly and submit them
      //   with the rest of the form
      if (navigator.appName=="Microsoft Internet Explorer") {
        var form   = document.getElementById(id).parentNode;
        // Create IMAGE.x form variable
        var element   = document.createElement("INPUT");
        element.type  = "hidden";
        element.name  = button.name + '.x';
        element.value = "1";
        form.appendChild(element);

        // Create IMAGE.y form variable
        element       = document.createElement("INPUT");
        element.type  = "hidden";
        element.name  = button.name + '.y';
        element.value = "1";
        form.appendChild(element);
      }

      // Now we can simulate the click
      button.click();
    } else {
      // Just do a plain submit
      document.forms[0].submit();
    }
  }
}

// open new window with specific width and height.
function open_new_window( url, action, name, winwidth, winheight) {
    var props = "width="+winwidth+",height="+winheight+",toolbar=no,directories=no,menubar=yes,resizable=yes,scrollbars=yes,dependent=yes";
    hwnd = window.open( url, name, props);
    hwnd.focus();
}

