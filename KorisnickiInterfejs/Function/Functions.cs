using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KorisnickiInterfejs.Function
{
    public static class Functions
    {
        public static decimal hours_add(decimal h1, decimal h2)
        {
            int z1;
            int z2;
            z1 = (int)(h1 * 100 / 100) * 60 + (int)(h1 * 100) % 100;
            z2 = (int)(h2 * 100 / 100) * 60 + (int)(h2 * 100) % 100;
            return (int)((z1 + z2) / 60) + (decimal)((z1 + z2) % 60) / 100;
        }

        public static decimal hours_sub(decimal h1, decimal h2)
        {
            int z1;
            int z2;
            z1 = (int)(h1 * 100 / 100) * 60 + (int)(h1 * 100) % 100;
            z2 = (int)(h2 * 100 / 100) * 60 + (int)(h2 * 100) % 100;
            return (int)((z1 - z2) / 60) + (decimal)((z1 - z2) % 60) / 100;
        }

    }
}
