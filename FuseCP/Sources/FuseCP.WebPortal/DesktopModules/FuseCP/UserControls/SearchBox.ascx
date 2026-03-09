<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchBox.ascx.cs" Inherits="FuseCP.Portal.SearchBox" %>

<script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/search-box.js"></script>
<input type="hidden" id="searchBoxConfig"
    data-filter-columns="<%= Server.HtmlEncode(GetCriterias()) %>"
    data-ajax-data="<%= Server.HtmlEncode(AjaxData ?? String.Empty) %>"
    data-submit-id="<%= cmdSearch.ClientID %>" />

<asp:Panel ID="tblSearch" runat="server" DefaultButton="cmdSearch" CssClass="NormalBold">
<asp:Label ID="lblSearch" runat="server" meta:resourcekey="lblSearch" Visible="false"></asp:Label>

<div class="input-group">
                <asp:DropDownList ClientIDMode="Static" ID="ddlFilterColumn" runat="server" CssClass="form-control" resourcekey="ddlFilterColumn" style="display:none">
                </asp:DropDownList>

                                <asp:TextBox
                                    ID="tbSearch"
                                    ClientIDMode="Static"
                                    runat="server"
                                    CssClass="form-control"
                                >
                                </asp:TextBox>
                                <asp:TextBox
                                    ID="tbSearchFullType"
                                    ClientIDMode="Static"
                                    runat="server"
                                    type="hidden"
                                >
                                </asp:TextBox>
                                <asp:TextBox
                                    ID="tbSearchText"
                                    ClientIDMode="Static"
                                    runat="server"
                                    type="hidden"
                                >
                                </asp:TextBox>
                                <asp:TextBox
                                    ID="tbObjectId"
                                    ClientIDMode="Static"
                                    runat="server"
                                    type="hidden"
                                >
                                </asp:TextBox>
                                <asp:TextBox
                                    ID="tbPackageId"
                                    ClientIDMode="Static"
                                    runat="server"
                                    type="hidden"
                                >
                                </asp:TextBox>
                                <asp:TextBox
                                    ID="tbAccountId"
                                    ClientIDMode="Static"
                                    runat="server"
                                    type="hidden"
                                >
                                </asp:TextBox>
                                <div class="d-flex">
                                <asp:LinkButton
                                    ID="cmdSearch"
                                    runat="server"
                                    SkinID="SearchButton"
                                    CausesValidation="false" CssClass="btn btn-primary align-middle"
                                    
                                   
                                >
                                    <i class="bi bi-search" aria-hidden="true"></i>
                                </asp:LinkButton>      
                                    </div>                
                            </div>

</asp:Panel>
