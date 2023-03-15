using Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.DBRepository
{
    public class AdminRepository
    {
        private static AdminRepository instance;

         private List<IDomainObject> korisnici;

        private AdminRepository()
        {
            korisnici = new List<IDomainObject>();
            InitKorisnici();
        }

        private void InitKorisnici()
        {
            korisnici.Add(new User { Username = "petar.petrovic", Password = "123456", Ime = "Petar", Prezime = "Petrovic" });
            korisnici.Add(new User { Username = "uros.novakovic", Password = "654321", Ime = "Uros", Prezime = "Novakovic" });
            korisnici.Add(new User { Username = "matija.colakovic", Password = "123654", Ime = "Matija", Prezime = "Colakovic" });

        }

        public static AdminRepository Instance
        {
            get
            {
                if (instance == null) instance = new AdminRepository();
                return instance;
            }
        }

        public List<IDomainObject> Korisnici { get => korisnici; }
    }
}
