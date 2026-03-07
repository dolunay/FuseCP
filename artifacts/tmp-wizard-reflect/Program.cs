using System;
using System.Linq;
using System.Web.UI.WebControls;

var props = typeof(WizardStep).GetProperties().OrderBy(p => p.Name);
foreach (var p in props)
{
    Console.WriteLine($"{p.Name} : {p.PropertyType.FullName}");
}
