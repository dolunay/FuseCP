<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CRMUserRoles.ascx.cs"
    Inherits="FuseCP.Portal.CRM.CRMUserRoles" %>
<%@ Register Src="../ExchangeServer/UserControls/UserSelector.ascx" TagName="UserSelector"
    TagPrefix="fcp" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox"
    TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport"
    TagPrefix="fcp" %>
<%@ Register Src="../UserControls/QuotaViewer.ascx" TagName="QuotaViewer" TagPrefix="fcp" %>
<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server" />
				<div class="card-header">
                    <h3 class="card-title">
                    <asp:Image ID="Image1" SkinID="CRMLogo" runat="server" />
                    <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle"></asp:Localize>
                </h3>
                        </div>
                <div class="card-body form-horizontal">
                    <fcp:SimpleMessageBox id="messageBox" runat="server" />

                    <div>

                        <div>
                            <table>
                                <tr height="23">
                                    <td class="FormLabel150"><asp:Localize runat="server" ID="locDisplayName" meta:resourcekey="locDisplayName" /></td>
                                    <td class="FormLabel150"><asp:Label runat="server" ID="lblDisplayName" /></td>
                                </tr>
                                <tr height="23">
                                    <td class="FormLabel150"><asp:Localize runat="server" ID="locEmailAddress" meta:resourcekey="locEmailAddress"/></td>
                                    <td class="FormLabel150"><asp:Label runat="server" ID="lblEmailAddress" /></td>
                                </tr>
                                <tr height="23">
                                    <td class="FormLabel150"><asp:Localize runat="server" ID="locDomainName" meta:resourcekey="locDomainName"/></td>
                                    <td class="FormLabel150"><asp:Label runat="server" ID="lblDomainName" /></td>
                                </tr>
                                <tr>
                                    <td><asp:Localize runat="server" ID="locState" meta:resourcekey="locState" /></td>
                                    <td><asp:Localize runat="server" ID="locEnabled" meta:resourcekey="locEnabled" /><asp:Localize runat="server" ID="locDisabled" meta:resourcekey="locDisabled" />&nbsp;
                                        <asp:LinkButton id="btnActive" CssClass="btn btn-success" runat="server" OnClick="btnActive_Click" meta:resourcekey="btnActivate"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="locBtnActivate" /> </asp:LinkButton>&nbsp;
                                        <asp:LinkButton id="btnDeactivate" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnDeactivate_Click" meta:resourcekey="btnDeactivate"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="locBtnDeactivate" /> </asp:LinkButton>

                                    </td>
                                </tr>

                                <tr>
                                    <td class="FormLabel150"><asp:Localize runat="server" meta:resourcekey="locLicenseType" Text="License Type:" /></td>
                                    <td>
                                        <asp:DropDownList ID="ddlLicenseType" runat="server" CssClass="form-control" AutoPostBack="false">
                                        </asp:DropDownList>
                                    </td>
                                </tr>

                            </table>
                            <br />
                        </div>
                        
                        <div>
                            <asp:GridView ID="gvRoles" runat="server" AutoGenerateColumns="False" EnableViewState="true"
                                 CssSelectorClass="NormalGridView" 
                                AllowPaging="False" AllowSorting="False" DataKeyNames="RoleID" >
                                <Columns>
                                    <asp:TemplateField >
                                        <ItemStyle  HorizontalAlign="Center" ></ItemStyle>
                                        <ItemTemplate >
                                            <asp:CheckBox runat="server" ID="cbSelected" Checked=<%# Eval("IsCurrentUserRole") %> />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="gvRole" DataField="RoleName" 
                                        />
                                    
                                </Columns>
                            </asp:GridView>
                        </div>
                   </div>
                </div>
  <div class="card-footer text-end">
        <asp:LinkButton id="btnUpdate" CssClass="btn btn-warning" runat="server" OnClick="btnUpdate_Click"> <i class="bi bi-arrow-clockwise">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnUpdate"/> </asp:LinkButton>&nbsp;
        <asp:LinkButton id="btnSaveExit" CssClass="btn btn-success" runat="server" OnClick="btnSaveExit_Click"> <i class="bi bi-floppy">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSaveExit"/> </asp:LinkButton>
  </div>
