using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    [Serializable]
    public class RotablePartsAircraft : IDomainObject
    {
        public RotablePartsLog RotablePartsLog { get; set; }
        public RotableParts RotableParts { get; set; }
        public Aircraft Aircraft { get; set; }
        public Decimal AircraftHours { get; set; }
        public Decimal AircraftCycles { get; set; }
        public DateTime InstalationDate { get; set; }
        public Decimal HoursOperationalLimit { get; set; }
        public Decimal CyclesOperationalLimit { get; set; }
        public Decimal DaysOperationalLimit { get; set; }
        public Decimal StorageLimit { get; set; }
        public Decimal TimeSinceNew { get; set; }
        public Decimal CyclesSinceNew { get; set; }
        public Decimal DaysSinceNew { get; set; }
        public Decimal TimeSinceOverhaul { get; set; }
        public Decimal CyclesSinceOverhaul { get; set; }
        public Decimal DaysSinceOverhaul { get; set; }
        public Decimal ExpireOnHours { get; set; }
        public Decimal ExpireOnCycles { get; set; }
        public DateTime ExpireAtDate { get; set; }

        public List<string> TableName => new List<string> { "RotablePartsAircraft", "RotablePartsAircraft output inserted.ID_RotablePartsLog" };
        private int _TableNameIndex;
        public int TableNameIndex { get => _TableNameIndex; set => _TableNameIndex = value; }

        public List<string> SelectFields => new List<string> { "RotablePartsAircraft.*" };
        private int _SelectFieldsIndex;
        public int SelectFieldsIndex { get => _SelectFieldsIndex; set => _SelectFieldsIndex = value; }

        public List<string> Condition => new List<string> { $"ID_RotablePartsLog = (select ID_RotablePartsLog FROM RotablePartsLog t1 Where ID_RotableParts = { RotableParts.ID_RotableParts } AND ID_SubClass = 1 AND (SELECT COUNT(*) FROM RotablePartsLog AS t2 Where t2.ID_RotablePartsLog > t1.ID_RotablePartsLog AND  t2.ID_RotableParts = t1.ID_RotableParts) = 0 )" };
        private int _ConditionIndex;
        public int ConditionIndex { get => _ConditionIndex; set => _ConditionIndex = value; }

        public string InsertValues => $"{RotablePartsLog.ID_RotablePartsLog}, {RotableParts.ID_RotableParts}, NULLIF('{Aircraft?.RegistrationNumber}',''), NULLIF({Aircraft?.LastACHours}, 0), NULLIF({Aircraft?.LastACCycles}, 0), convert(datetime, '{Aircraft ?.LastUpdate.ToString("yyyyMMdd HH:mm:ss")}', 103), {HoursOperationalLimit}, {CyclesOperationalLimit}, {DaysOperationalLimit}, {StorageLimit}, {TimeSinceNew}, {CyclesSinceNew}, {DaysSinceNew}, {TimeSinceOverhaul}, {CyclesSinceOverhaul}, {DaysSinceOverhaul}, {ExpireOnHours}, {ExpireOnCycles}, convert(datetime, '{ExpireAtDate.ToString("yyyyMMdd HH:mm:ss")}')";

        public string UpdateValues => throw new NotImplementedException();

        public string SelectOrderBy => "ID_RotableParts";

        public List<IDomainObject> ReadMultipleRow(SqlDataReader reader)
        {
            List<IDomainObject> rotablePartsAircraft = new List<IDomainObject>();
            while (reader.Read())
            {
                rotablePartsAircraft.Add(new RotablePartsAircraft
                {
                    RotablePartsLog = new RotablePartsLog
                    {
                        ID_RotablePartsLog = reader.GetDecimal(0)
                    },
                    RotableParts = new RotableParts
                    {
                        ID_RotableParts = reader.GetDecimal(1)
                    },
                    Aircraft = new Aircraft
                    {
                        RegistrationNumber = reader.IsDBNull(2) ? string.Empty : reader.GetString(2),
                    },
                    AircraftHours = reader.IsDBNull(3) ? 0 : reader.GetDecimal(3),
                    AircraftCycles = reader.IsDBNull(4) ? 0 : reader.GetDecimal(4),
                    InstalationDate = reader.GetDateTime(5),
                    HoursOperationalLimit = reader.GetDecimal(6),
                    CyclesOperationalLimit = reader.GetDecimal(7),
                    DaysOperationalLimit = reader.GetDecimal(8),
                    StorageLimit = reader.GetDecimal(9),
                    TimeSinceNew = reader.GetDecimal(10),
                    CyclesSinceNew = reader.GetDecimal(11),
                    DaysSinceNew = reader.GetDecimal(12),
                    TimeSinceOverhaul = reader.GetDecimal(13),
                    CyclesSinceOverhaul = reader.GetDecimal(14),
                    DaysSinceOverhaul = reader.GetDecimal(15),
                    ExpireOnHours = reader.GetDecimal(16),
                    ExpireOnCycles = reader.GetDecimal(17),
                    ExpireAtDate = reader.GetDateTime(18)

                });
            }
            return rotablePartsAircraft;
        }

        public IDomainObject ReadSingleRow(SqlDataReader reader)
        {
            IDomainObject rotablePartsAircraft;
            if (!reader.HasRows) return null;
            reader.Read();
            
                rotablePartsAircraft = new RotablePartsAircraft
                {
                    RotablePartsLog = new RotablePartsLog
                    {
                        ID_RotablePartsLog = reader.GetDecimal(0)
                    },
                    RotableParts = new RotableParts
                    {
                        ID_RotableParts = reader.GetDecimal(1)
                    },
                    Aircraft = new Aircraft
                    {
                        RegistrationNumber = reader.IsDBNull(2) ? string.Empty : reader.GetString(2),
                    },
                    AircraftHours = reader.IsDBNull(3) ? 0 : reader.GetDecimal(3),
                    AircraftCycles = reader.IsDBNull(4) ? 0 : reader.GetDecimal(4),
                    InstalationDate = reader.GetDateTime(5),
                    HoursOperationalLimit = reader.GetDecimal(6),
                    CyclesOperationalLimit = reader.GetDecimal(7),
                    DaysOperationalLimit = reader.GetDecimal(8),
                    StorageLimit = reader.GetDecimal(9),
                    TimeSinceNew = reader.GetDecimal(10),
                    CyclesSinceNew = reader.GetDecimal(11),
                    DaysSinceNew = reader.GetDecimal(12),
                    TimeSinceOverhaul = reader.GetDecimal(13),
                    CyclesSinceOverhaul = reader.GetDecimal(14),
                    DaysSinceOverhaul = reader.GetDecimal(15),
                    ExpireOnHours = reader.GetDecimal(16),
                    ExpireOnCycles = reader.GetDecimal(17),
                    ExpireAtDate = reader.GetDateTime(18)

                };
            
            return rotablePartsAircraft;
        }
    }
}
