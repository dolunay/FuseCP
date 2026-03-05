<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WebSitesEditVirtualDir.ascx.cs" Inherits="FuseCP.Portal.WebSitesEditVirtualDir" %>
<%@ Register Src="WebSitesCustomErrorsControl.ascx" TagName="WebSitesCustomErrorsControl" TagPrefix="uc4" %>
<%@ Register Src="WebSitesMimeTypesControl.ascx" TagName="WebSitesMimeTypesControl" TagPrefix="uc5" %>
<%@ Register Src="VirtualDirectoryHomeFolderControl.ascx" TagName="VirtualDirectoryHomeFolderControl" TagPrefix="uc1" %>
<%@ Register Src="WebSitesCustomHeadersControl.ascx" TagName="WebSitesCustomHeadersControl" TagPrefix="uc6" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport ID="asyncTasks" runat="server" />

<div class="card-body form-horizontal">
    <table width="100%">
        <tr>
            <td class="align-top" width="100%">
                <table>
                    <tr>
                        <td class="Big">
                            <asp:HyperLink ID="lnkSiteName" runat="server" NavigateUrl="#" Target="_blank">domain.com/vdir</asp:HyperLink>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="widget">
                    <div class="widget-header clearfix">
                        <ul class="nav nav-tabs">
                            <asp:DataList ID="dlTabs" runat="server" RepeatDirection="Horizontal"
                                OnSelectedIndexChanged="dlTabs_SelectedIndexChanged" RepeatLayout="Flow">
                                <ItemStyle Wrap="False" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="cmdSelectTab" runat="server" CommandName="select" CssClass="Tab">
                                        <%# Eval("Name") %>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <SelectedItemStyle Wrap="False" />
                                <SelectedItemTemplate>
                                    <asp:LinkButton ID="cmdSelectTab" runat="server" CommandName="select" CssClass="ActiveTab">
                                        <%# Eval("Name") %>
                                    </asp:LinkButton>
                                </SelectedItemTemplate>
                            </asp:DataList>
                        </ul>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $('.nav-tabs li').unwrap();
                                $('.nav-tabs li').unwrap();
                            });
                        </script>
                    </div>
                    <div class="widget-content tab-content">
                        <div class="card-body form-horizontal">
                            <asp:MultiView ID="tabs" runat="server" ActiveViewIndex="0">
                                <asp:View ID="tabHomeFolder" runat="server">
                                    <uc1:VirtualDirectoryHomeFolderControl ID="VirtualDirectoryHomeFolderControl" runat="server" IsVirtualDirectory="true" />
                                </asp:View>

                                <%--<asp:View ID="tabErrors" runat="server">
                                    <uc4:WebSitesCustomErrorsControl ID="webSitesCustomErrorsControl" runat="server" />
                                </asp:View>

                                <asp:View ID="tabHeaders" runat="server">
                                    <uc6:WebSitesCustomHeadersControl ID="webSitesCustomHeadersControl" runat="server" />
                                </asp:View>

                                <asp:View ID="tabMimes" runat="server">
                                    <uc5:WebSitesMimeTypesControl ID="webSitesMimeTypesControl" runat="server" />
                                </asp:View>--%>

                            </asp:MultiView>
                        </div>
                        <div class="card-footer text-end">
                            <asp:LinkButton ID="btnDelete" CssClass="btn btn-danger" runat="server" OnClick="btnDelete_Click" CausesValidation="false" OnClientClick="return confirm('Delete this virtual directory?');">
                                <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText" />
                            </asp:LinkButton>
                            &nbsp;
                    <asp:LinkButton ID="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click">
                        <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel" />
                    </asp:LinkButton>
                            &nbsp;
                    <asp:LinkButton ID="btnUpdate" CssClass="btn btn-success" runat="server" OnClick="btnUpdate_Click" OnClientClick="ShowProgressDialog('Please Wait! Updating virtual directory...');">
                        <i class="bi bi-arrow-clockwise">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnUpdateText" />
                    </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>
