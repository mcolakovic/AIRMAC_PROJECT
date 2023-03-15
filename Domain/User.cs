using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    [Serializable]
    public class User : IDomainObject
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string IPAdresa { get; set; }
        public string VrijemePristupa { get; set; }

        public override bool Equals(object obj)
        {
            if (obj is User u) return u.Username == Username && u.Password == Password;
            return false;
        }

        public List<string> TableName => new List<string> { "Korisnici" };
        private int _TableNameIndex;
        public int TableNameIndex { get => _TableNameIndex; set => _TableNameIndex = value; }

        public List<string> SelectFields => new List<string> {  };
        private int _SelectFieldsIndex;
        public int SelectFieldsIndex { get => _SelectFieldsIndex; set => _SelectFieldsIndex = value; }

        public List<string> Condition => new List<string> { $"{Username}", $"{Password}" };
        private int _ConditionIndex;
        public int ConditionIndex { get => _ConditionIndex; set => _ConditionIndex = value; }


        public string InsertValues => throw new NotImplementedException();

        public string UpdateValues => throw new NotImplementedException();

        public string SelectOrderBy => throw new NotImplementedException();

        public List<IDomainObject> ReadMultipleRow(SqlDataReader reader)
        {
            throw new NotImplementedException();
        }

        public IDomainObject ReadSingleRow(SqlDataReader reader)
        {
            throw new NotImplementedException();
        }
    }
}
