
var model = null;
var clip = null;

function Step(step, comment) {
	this.Step = ko.observable(step);
	this.Comment = ko.observable(comment);
}

function CreateModel() {
	var self = this;

	//public Steps collection
	self.Steps = ko.observableArray([]);

	//public AddStep method
	self.AddStep = function (stepContent, stepDefComment) {
		self.Steps.push(new Step(stepContent,stepDefComment));
	}

	//public RemoveStep method
	self.RemoveStep = function (step) {
		self.Steps.remove(step);
	}
}



$(function () {


	model = new CreateModel();
	ko.applyBindings(model);


	//jquery sort applied to steps
	//sortable does not work well with the knockout
	//so comment out this line until find a solution

	//$("#sortable").sortable();


	//	//deal with the input can't be focused bug,
	//	$('#sortable input').bind('click.sortable mousedown.sortable', function (ev) {
	//		ev.target.focus();
	//	});


	//jquery accordion applied to step defs
	$(".accordionCate").accordion({
		alwaysOpen: false,
		heightStyle: "content",
		collapsible: true, active: false,
		autoHeight: false
	});


	//jquery tooltip
	$(document).tooltip({
		show: {
			delay: 500
		},
		//track:true,		// show at where the mouse is
		items: "[title]", //only show tooltips on those elements that has title attribute
		content: function () {  //get content from sub element
			var self = $(this);
			var title = self.attr("title");
			if (title && title != "")
				return title;
			else
				return self.find("div").html();

		}
	});

	//jquery accordion applied to step defs
	$(".accordion").accordion({
		heightStyle: "content",
		collapsible: true
	});


	//click step def to add step
	$("ul.stepDefs li").mousedown(function () {


		//retrive the current html
		var regex = $(this).find("span").html();
		var comment = $(this).find("div").html();


		regex = regex.replaceAll("([^\"]*)", "____");

		regex = regex.replaceAll("([^\"]+)", "____");
		regex = regex.replaceAll("(.*)", "____");
		regex = regex.replaceAll("(.+)", "____");


		//append ...
		model.AddStep(regex, comment);


		$(this).animate({
			backgroundColor: "#9cf"

		}, "50", "swing", function () {
			$(this).animate({
				backgroundColor: "#fff"

			}, "50", "swing")
		});

	});

	//



	
	clip = new ZeroClipboard.Client();

	clip.addEventListener('mouseOver', function (client) {
		var text = "";
		var steps = model.Steps();

		for(var i =0;i<steps.length;i++)
		{
			text += steps[i].Step() + "\r\n";
		}

		
		clip.setText(text);
	});


	clip.glue('d_clip_button');



});


//string replaceAll()
String.prototype.replaceAll = function (token, newToken, ignoreCase) {
	var str, i = -1, _token;
	if ((str = this.toString()) && typeof token === "string") {
		_token = ignoreCase === true ? token.toLowerCase() : undefined;
		while ((i = (
            _token !== undefined ?
                str.toLowerCase().indexOf(
                            _token,
                            i >= 0 ? i + newToken.length : 0
                ) : str.indexOf(
                            token,
                            i >= 0 ? i + newToken.length : 0
                )
        )) !== -1) {
			str = str.substring(0, i)
                    .concat(newToken)
                    .concat(str.substring(i + token.length));
		}
	}
	return str;
};
