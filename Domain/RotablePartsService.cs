using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    [Serializable]
    public class RotablePartsService : IDomainObject
    {
        public RotablePartsLog RotablePartsLog { get; set; }
        public RotableParts RotableParts { get; set; }
        public string WorkOrder { get; set; }
        public string WorkOrderDescription { get; set; }
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
        public Decimal ID_ResultOfInspection { get; set; }
        public Decimal NewHoursOperationalLimit { get; set; }
        public Decimal NewCyclesOperationalLimit { get; set; }
        public Decimal NewDaysOperationalLimit { get; set; }
        public Decimal NewStorageLimit { get; set; }
        public string Description { get; set; }


        public List<string> TableName => new List<string> { "RotablePartsService", "RotablePartsService output inserted.ID_RotablePartsLog" };
        private int _TableNameIndex;
        public int TableNameIndex { get => _TableNameIndex; set => _TableNameIndex = value; }

        public List<string> SelectFields => new List<string> { "RotablePartsService.*" };
        private int _SelectFieldsIndex;
        public int SelectFieldsIndex { get => _SelectFieldsIndex; set => _SelectFieldsIndex = value; }

        public List<string> Condition => new List<string> { $"ID_RotablePartsLog = (select ID_RotablePartsLog FROM RotablePartsLog t1 Where ID_RotableParts = { RotableParts?.ID_RotableParts } AND ID_SubClass = 3 AND (SELECT COUNT(*) FROM RotablePartsLog AS t2 Where t2.ID_RotablePartsLog > t1.ID_RotablePartsLog AND  t2.ID_RotableParts = t1.ID_RotableParts) = 0 )", $"ID_RotablePartsLog = {RotablePartsLog?.ID_RotablePartsLog}" };
        private int _ConditionIndex;
        public int ConditionIndex { get => _ConditionIndex; set => _ConditionIndex = value; }

        public string InsertValues => $"{RotablePartsLog.ID_RotablePartsLog}, {RotableParts.ID_RotableParts}, '{WorkOrder}', '{WorkOrderDescription}', {HoursOperationalLimit}, {CyclesOperationalLimit}, {DaysOperationalLimit}, {StorageLimit}, {TimeSinceNew}, {CyclesSinceNew}, {DaysSinceNew}, {TimeSinceOverhaul}, {CyclesSinceOverhaul}, {DaysSinceOverhaul}, NULLIF({ID_ResultOfInspection},0), NULLIF({NewHoursOperationalLimit},0), NULLIF({NewCyclesOperationalLimit},0), NULLIF({NewDaysOperationalLimit},0), NULLIF({NewStorageLimit},0), NULLIF('{Description}','')";

        public string UpdateValues => $"ID_ResultOfInspection = NULLIF({ID_ResultOfInspection},0), NewHoursOperationalLimit = NULLIF({NewHoursOperationalLimit},0), NewCyclesOperationalLimit = NULLIF({NewCyclesOperationalLimit},0), NewDaysOperationalLimit = NULLIF({NewDaysOperationalLimit},0), NewStorageLimit = NULLIF({NewStorageLimit},0), Description = NULLIF('{Description}','')";

        public string SelectOrderBy => "ID_RotableParts";

        public List<IDomainObject> ReadMultipleRow(SqlDataReader reader)
        {
            List<IDomainObject> rotablePartsService = new List<IDomainObject>();
            while (reader.Read())
            {
                rotablePartsService.Add(new RotablePartsService
                {
                    RotablePartsLog = new RotablePartsLog
                    {
                        ID_RotablePartsLog = reader.GetDecimal(0)
                    },
                    RotableParts = new RotableParts
                    {
                        ID_RotableParts = reader.GetDecimal(1)
                    },
                    WorkOrder = reader.GetString(2),
                    WorkOrderDescription = reader.GetString(3),
                    HoursOperationalLimit = reader.GetDecimal(4),
                    CyclesOperationalLimit = reader.GetDecimal(5),
                    DaysOperationalLimit = reader.GetDecimal(6),
                    StorageLimit = reader.GetDecimal(7),
                    TimeSinceNew = reader.GetDecimal(8),
                    CyclesSinceNew = reader.GetDecimal(9),
                    DaysSinceNew = reader.GetDecimal(10),
                    TimeSinceOverhaul = reader.GetDecimal(11),
                    CyclesSinceOverhaul = reader.GetDecimal(12),
                    DaysSinceOverhaul = reader.GetDecimal(13),
                    ID_ResultOfInspection = reader.IsDBNull(14) ? 0 : reader.GetDecimal(14),
                    NewHoursOperationalLimit = reader.IsDBNull(15) ? 0 : reader.GetDecimal(15),
                    NewCyclesOperationalLimit = reader.IsDBNull(16) ? 0 : reader.GetDecimal(16),
                    NewDaysOperationalLimit = reader.IsDBNull(17) ? 0 : reader.GetDecimal(17),
                    NewStorageLimit = reader.IsDBNull(18) ? 0 : reader.GetDecimal(18),
                    Description = reader.IsDBNull(19) ? string.Empty : reader.GetString(19)

                });
            }
            return rotablePartsService;
        }

        public IDomainObject ReadSingleRow(SqlDataReader reader)
        {
            IDomainObject rotablePartsService;
            if (!reader.HasRows) return null;

            reader.Read();
            
                rotablePartsService = new RotablePartsService
                {
                    RotablePartsLog = new RotablePartsLog
                    {
                        ID_RotablePartsLog = reader.GetDecimal(0)
                    },
                    RotableParts = new RotableParts
                    {
                        ID_RotableParts = reader.GetDecimal(1)
                    },
                    WorkOrder = reader.GetString(2),
                    WorkOrderDescription = reader.GetString(3),
                    HoursOperationalLimit = reader.GetDecimal(4),
                    CyclesOperationalLimit = reader.GetDecimal(5),
                    DaysOperationalLimit = reader.GetDecimal(6),
                    StorageLimit = reader.GetDecimal(7),
                    TimeSinceNew = reader.GetDecimal(8),
                    CyclesSinceNew = reader.GetDecimal(9),
                    DaysSinceNew = reader.GetDecimal(10),
                    TimeSinceOverhaul = reader.GetDecimal(11),
                    CyclesSinceOverhaul = reader.GetDecimal(12),
                    DaysSinceOverhaul = reader.GetDecimal(13),
                    ID_ResultOfInspection = reader.IsDBNull(14) ? 0 : reader.GetDecimal(14),
                    NewHoursOperationalLimit = reader.IsDBNull(15) ? 0 : reader.GetDecimal(15),
                    NewCyclesOperationalLimit = reader.IsDBNull(16) ? 0 : reader.GetDecimal(16),
                    NewDaysOperationalLimit = reader.IsDBNull(17) ? 0 : reader.GetDecimal(17),
                    NewStorageLimit = reader.IsDBNull(18) ? 0 : reader.GetDecimal(18),
                    Description = reader.IsDBNull(19) ? string.Empty : reader.GetString(19)

                };
            
            return rotablePartsService;
        }
    }
}
