<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AutoCompleteSearch.aspx.cs" Inherits="AutoCompleteSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Auto Complete Search Box</title>

    <link type="text/css" rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>


    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <style>
        #tblSearchStydents {
            width: 100%;
            border-collapse: collapse;
            width: 100%;
        }

        #tblSearchStydents td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
            font-family: Arial;
            font-size: 16px;
        }
            

        #tblSearchStydents tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>

     <script type="text/javascript">

        window.onload = function () {
            if ($(window).width() < 700) {
                $("#searchInput").attr("placeholder", "SEARCH");
            }
            else {
                $("#searchInput").attr("placeholder", "Enter name to search");
            }
        }

        $(function () {

            /*autocomplete code*/
            $("#searchInput").keyup(function () {
                if ($("#searchInput").val().trim() == '') {
                    $("#auto_complete").css("border", "none");
                    $("#auto_complete").css("height", "0");
                    $("#auto_complete").html('');

                    return;
                }

                if ($("#searchInput").val().length < 3) {
                    $("#auto_complete").css("border", "none");
                    $("#auto_complete").css("height", "0");
                    $("#auto_complete").html('');

                    return;
                }

                $("#auto_complete").css("height", "200px");
                $("#searchInput").val($("#searchInput").val().replace(',', ' ').replace('#', ' '));

                var post_data = JSON.stringify({ "search_term": $("#searchInput").val() });
                console.log(post_data);
                $.ajax({

                    type: "POST",
                    url: "AutoCompleteSearch.aspx/GetJSON",
                    data: post_data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result, status, xhr) {
                        //loader.css("display", "none");
                        //console.log(result);

                        console.log("RESPONSE DATA ", result.d);
                        if (result.d.length == 0) {
                            $("#auto_complete").css("border", "none");
                            $("#auto_complete").css("height", "0");
                            $("#auto_complete").html('');
                            return;
                        }

                        var json_data = JSON.parse(result.d);

                        var list = '';

                        $.map(json_data, function (item) {                            
                            var table = '<table id="tblSearchStydents"><tr><td style="width:35%;">' + item.name.toUpperCase() + '</td><td style="width:35%;">' + item.city.toUpperCase() + '</td><td style="width:20%;">' + item.phone.toUpperCase() + '</td><td style="width:10%;">' + item.salary + '</td></tr></table>';
                            list += '<a href="#" style="color:black;" onclick=\"TriggerSearchButton(\'' + item.id + '\')\">' + table + '</a>';
                        });

                        $("#auto_complete").html('');
                        $("#auto_complete").html(list);
                        
                        $("#auto_complete").css("border", "solid 1px #84B7FE");


                    },
                    error: function (req, status, err) {
                        //loader.css("display", "none");

                        console.log("AJAX ERROR", err);
                    }

                });
            });
        });

        function closeAutoComplete() {
            $("#auto_complete").css("border", "none");
            $("#auto_complete").css("height", "0");
            $("#auto_complete").html('');
            $("#searchInput").focus();
            return false;
        }

        function TriggerSearchButton(id) {
            document.getElementById("UserName_hf").value = id;
            if (document.getElementById("<%=btnSearch.ClientID%>") != null) {
                document.getElementById("<%=btnSearch.ClientID%>").click();
            }
            else {
                closeAutoComplete();
            }

            alert(document.getElementById("UserName_hf").value);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="UserName_hf" runat="server" />
    <div class="container">

            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <h2 id="heading">AutoComplete Search Box</h2>
                </div>

            </div>
            
            <br />
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <input type="text" class="form-control" id="searchInput" autocomplete="off" />
                    <div id="auto_complete" style="position: absolute; z-index: 100; width: 95%; max-height: 200px; line-height: 40px; overflow: auto; background-color: #EFEFEF;"></div>
                </div>
                <div class="col-md1">

                    <button id="btnReset" class="btn btn-primary btn-block" onclick="return closeAutoComplete()">RESET</button>
                </div>
                <div class="col-md1">
                    <asp:Button ID="btnSearch" runat="server" class="btn btn-primary btn-block" OnClick="btnSearch_btn_Click" Style="display: none;" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
