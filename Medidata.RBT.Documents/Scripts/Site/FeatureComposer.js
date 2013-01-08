
var model = null;	//nockout clint model
var clip = null;	//clipboard object of zClipboard

//client side models----------------------

function Step(step, comment) {
	this.Step = ko.observable(step);
	this.Comment = ko.observable(comment);
}


function CreateModel() {
	var self = this;

	//public StepDefs collection
	self.StepDefCategories = ko.observableArray([]);

	self.ToolsLoaded = ko.observable(false);

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



	self.LoadStepDefs = function (callback) {
		$.getJSON(siteURL + "api/docapi", function (allData) {
			self.ToolsLoaded(true);
			//you can map the returned json to a defined client model, 
			// or set it directly to StepDefCategories
			//$.map(allData, function (item) { return new StepDefCategory(item) });

			//add a Visible property to category model and the stepDefClasses inside cateogry
			for (var i = 0; i < allData.length; i++) {
				allData[i].Visible = ko.observable(true);
				for (var j = 0; j < allData[i].StepDefClasses.length; j++) {
					allData[i].StepDefClasses[j].Visible = ko.observable(true);
					allData[i].StepDefClasses[j].toggleVisible = function (item, event) {
						item.Visible(!item.Visible());
					}
				}
			}

			self.StepDefCategories(allData);

			MakeAccordion();

			//set them to false after accordion is made, because otherwise accordion will not be properly applied to hidden stepDefClass
			for (var i = 0; i < allData.length; i++) {
				for (var j = 0; j < allData[i].StepDefClasses.length; j++) {
					allData[i].StepDefClasses[j].Visible(false);
				}
			}

			if (callback)
				callback();

		});

	}

	function MakeAccordion() {
		//jquery accordion applied to step defs
		$(".accordionCate").accordion({

			heightStyle: "content",
			collapsible: true, active: false,
			autoHeight: false
		});

		//jquery accordion applied to step defs
		$(".accordion").accordion({
		
			heightStyle: "content",
			collapsible: true, active: false,
			autoHeight: false
		});
	}
}


//page load

function setupClipboard() {
	ZeroClipboard.setMoviePath(relURL + "zeroclipboard/ZeroClipboard2.swf");

	clip = new ZeroClipboard.Client();

	clip.addEventListener('mouseOver', function (client) {
		var text = "";
		var steps = model.Steps();

		for (var i = 0; i < steps.length; i++) {
			text += steps[i].Step() + "\r\n";
		}


		clip.setText(text);
	});

	clip.glue('d_clip_button');

}

$(function () {

	//knockout client side MVVM bindnig
	model = new CreateModel();
	ko.applyBindings(model);
	model.LoadStepDefs(setupClipboard); 



	//	//deal with the input can't be focused bug,
	//	$('#sortable input').bind('click.sortable mousedown.sortable', function (ev) {
	//		ev.target.focus();
	//	});


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


	//click step def to add step
	$("ul.stepDefs li").live('mousedown', function () {


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
