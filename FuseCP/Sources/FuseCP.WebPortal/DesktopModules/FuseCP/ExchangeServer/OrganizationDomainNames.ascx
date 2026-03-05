<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrganizationDomainNames.ascx.cs" Inherits="FuseCP.Portal.ExchangeServer.OrganizationDomainNames" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/QuotaViewer.ascx" TagName="QuotaViewer" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server"/>

				<div class="card-header">
                    <h3 class="card-title">
					<asp:Image ID="Image1" SkinID="ExchangeDomainName48" runat="server" />
					<asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Domain Names"></asp:Localize>
                    </h3>
				</div>
                <div class="FormButtonsBar right">
                        <asp:LinkButton id="btnAddDomain" CssClass="btn btn-primary" runat="server" OnClick="btnAddDomain_Click"> <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddDomainText"/> </asp:LinkButton>&nbsp;
                </div>
				    <fcp:SimpleMessageBox id="messageBox" runat="server" />
				    <asp:GridView ID="gvDomains" runat="server" AutoGenerateColumns="False"
					    Width="100%" EmptyDataText="gvDomains" CssSelectorClass="NormalGridView" OnRowCommand="gvDomains_RowCommand">
					    <Columns>
						    <asp:TemplateField SortExpression="DomainName" HeaderText="gvDomainsName">
							    <ItemStyle Width="50%"></ItemStyle>
							    <ItemTemplate>
								    <asp:hyperlink id="lnkEditZone" runat="server" EnableViewState="false"
									    NavigateUrl='<%# GetDomainRecordsEditUrl(Eval("DomainID").ToString()) %>' Enabled="true">
									    <%# Eval("DomainName") %>
								    </asp:hyperlink>
							    </ItemTemplate>
						    </asp:TemplateField>
						    <asp:TemplateField HeaderText="gvDomainsDefault">
							    <ItemTemplate>
							        <div style="text-align:left">
								        <input type="radio" name="DefaultDomain" value='<%# Eval("DomainId") %>' <%# IsChecked((bool)Eval("IsDefault")) %> />
								    </div>
							    </ItemTemplate>
						    </asp:TemplateField>                            
						    <asp:TemplateField>
							    <ItemTemplate>
									<asp:LinkButton id="imgDelDomain" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("DomainId") %>' Visible='<%# !((bool)Eval("IsDefault")) %>' OnClientClick="return confirm('Are you sure you want to delete selected domain?')"> &nbsp;<i class="bi bi-trash"></i>&nbsp; </asp:LinkButton>
							    </ItemTemplate>
						    </asp:TemplateField>
					    </Columns>
				    </asp:GridView>
				    <div class="card-footer">
                        <div class="row">
                            <div class="col-md-6">
                                		    <asp:Localize ID="locQuota" runat="server" meta:resourcekey="locQuota" Text="Total Domains Used:"></asp:Localize>
				    &nbsp;&nbsp;&nbsp;
				    <fcp:QuotaViewer ID="domainsQuota" runat="server" QuotaTypeId="2" />
                            </div>
                            <div class="col-md-6 text-end">
                                     <asp:LinkButton id="btnSetDefaultDomain" CssClass="btn btn-success" runat="server" OnClick="btnSetDefaultDomain_Click"> <i class="bi bi-globe">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSetDefaultDomainText"/> </asp:LinkButton>&nbsp;
   
                            </div>
                        </div>
				</div>
