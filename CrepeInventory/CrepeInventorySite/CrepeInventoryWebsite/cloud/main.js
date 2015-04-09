
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


//var sendgrid = require("sendgrid");
//
//sendgrid.initialize("sendgrid_username", "sendgrid_password");
//SendGrid.sendEmail({
//                   to: ["email@example.com (mailto:email@example.com)", "email+1@example.com"],
//                   from: "SendGrid@CloudCode.com (mailto:SendGrid@CloudCode.com)",
//                   subject: "Hello from Cloud Code!",
//                   text: "Using Parse and SendGrid is great!",
//                   replyto: "reply@example.com (mailto:reply@example.com)"
//                   }).then(function(httpResponse) {
//                           console.log(httpResponse);
//                           response.success("Email sent!");
//                           },function(httpResponse) {
//                           console.error(httpResponse);
//                           response.error("Uh oh, something went wrong");
//                           });

var sendgrid = require("sendgrid");
sendgrid.initialize("yoblob", "Indigo01");

Parse.Cloud.define("mySendGridFunction", function(request, response) {
                   sendgrid.sendEmail({
                                      to: "yoblob@gmail.com",
                                      from: "yoblob@gmail.com",
                                      subject: "Hello from Cloud Code!",
                                      text: "Using Parse and SendGrid is great!"
                                      }, {
                                      success: function(httpResponse) { response.success("Email sent!"); },
                                      error: function(httpResponse) { response.error("Uh oh, something went wrong"); }
                                      });
                   });


Parse.Cloud.define("checkBaseline", function(request, response) {
                   var query = new Parse.Query("ShiftInventory");
                   query.equalTo("processed", false);
                   query.find({
                              success: function(results) {
                              var sum = 0;
                              for (var i = 0; i < results.length; ++i)
                              {
                                  var items = results[i].get("inventoryItems");
                                  for(var j=0; j < items.length; ++j)
                                  {
                                    var crap = items[j];
                                    console.log(crap);
                                  }
                              }
                              response.success("weeee");
                              },
                              error: function() {
                              response.error("shift inventory lookup failed");
                              }
                              });
                   });