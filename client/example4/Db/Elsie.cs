using Microsoft.EntityFrameworkCore;
using example4.Models;
using System;

#nullable disable

namespace example4.Db
{
    public partial class Elsie : DbContext
    {
        public Elsie()
        {
        }

        public Elsie(DbContextOptions<Elsie> options)
            : base(options)
        {
        }

        public virtual DbSet<Inventory> Inventories { get; set; }
        public virtual DbSet<InventoryServiceStat> InventoryServiceStats { get; set; }
        public virtual DbSet<InventoryStaff1nf> InventoryStaff1nfs { get; set; }
        public virtual DbSet<MvInventoryServiceStat> MvInventoryServiceStats { get; set; }
        public virtual DbSet<ParkingSpot> ParkingSpots { get; set; }
        public virtual DbSet<Passkey> Passkeys { get; set; }
        public virtual DbSet<Service> Services { get; set; }
        public virtual DbSet<Shift> Shifts { get; set; }
        public virtual DbSet<ShiftStaff> ShiftStaffs { get; set; }
        public virtual DbSet<StaffInventory> StaffInventories { get; set; }
        public virtual DbSet<StaffInventory2nf> StaffInventory2nfs { get; set; }
        public virtual DbSet<Staff> Staff { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder
                    .UseNpgsql("Host=sql-in-7-days-database;Username=elsie;Database=advanced;")
                    .LogTo(Console.Error.WriteLine, minimumLevel: Microsoft.Extensions.Logging.LogLevel.Information);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "en_US.utf8");

            modelBuilder.Entity<Inventory>(entity =>
            {
                entity.HasKey(e => e.InventoryNumber)
                    .HasName("inventory_pkey");

                entity.ToTable("inventory");

                entity.HasIndex(e => e.Price, "inventory_price");

                entity.Property(e => e.InventoryNumber)
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.Property(e => e.Comment)
                    .HasMaxLength(200)
                    .HasColumnName("comment");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(200)
                    .HasColumnName("name");

                entity.Property(e => e.Price)
                    .HasPrecision(12, 2)
                    .HasColumnName("price");
            });

            modelBuilder.Entity<InventoryServiceStat>(entity =>
            {
                entity.HasKey(e => e.InventoryNumber)
                    .HasName("inventory_service_stats_pkey");

                entity.ToTable("inventory_service_stats");

                entity.Property(e => e.InventoryNumber)
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.Property(e => e.JobCount).HasColumnName("job_count");

                entity.HasOne(d => d.InventoryNumberNavigation)
                    .WithOne(p => p.InventoryServiceStat)
                    .HasForeignKey<InventoryServiceStat>(d => d.InventoryNumber)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("inventory_service_stats_inventory_number_fkey");
            });

            modelBuilder.Entity<InventoryStaff1nf>(entity =>
            {
                entity.HasKey(e => e.InventoryNumber)
                    .HasName("inventory_staff_1nf_pkey");

                entity.ToTable("inventory_staff_1nf");

                entity.Property(e => e.InventoryNumber)
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.Property(e => e.StaffIds).HasColumnName("staff_ids");

                entity.HasOne(d => d.InventoryNumberNavigation)
                    .WithOne(p => p.InventoryStaff1nf)
                    .HasForeignKey<InventoryStaff1nf>(d => d.InventoryNumber)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("inventory_staff_1nf_inventory_number_fkey");
            });

            modelBuilder.Entity<MvInventoryServiceStat>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("mv_inventory_service_stats");

                entity.Property(e => e.InventoryNumber)
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.Property(e => e.JobCount).HasColumnName("job_count");
            });

            modelBuilder.Entity<ParkingSpot>(entity =>
            {
                entity.ToTable("parking_spot");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Color)
                    .IsRequired()
                    .HasColumnName("color");
            });

            modelBuilder.Entity<Passkey>(entity =>
            {
                entity.HasKey(e => e.Serial)
                    .HasName("passkey_pkey");

                entity.ToTable("passkey");

                entity.HasIndex(e => e.Code, "passkey_code_key")
                    .IsUnique();

                entity.HasIndex(e => e.Staff, "passkey_staff_key")
                    .IsUnique();

                entity.Property(e => e.Serial)
                    .ValueGeneratedNever()
                    .HasColumnName("serial");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.Staff).HasColumnName("staff");

                entity.HasOne(d => d.StaffNavigation)
                    .WithOne(p => p.Passkey)
                    .HasForeignKey<Passkey>(d => d.Staff)
                    .HasConstraintName("passkey_staff_fkey");
            });

            modelBuilder.Entity<Service>(entity =>
            {
                entity.ToTable("service");

                entity.HasIndex(e => e.ServiceDate, "service_date");

                entity.HasIndex(e => e.InventoryNumber, "service_inventory_number");

                entity.Property(e => e.ServiceId).HasColumnName("service_id");

                entity.Property(e => e.Comment)
                    .IsRequired()
                    .HasMaxLength(200)
                    .HasColumnName("comment");

                entity.Property(e => e.InventoryNumber)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.Property(e => e.ServiceDate)
                    .HasColumnType("date")
                    .HasColumnName("service_date");

                entity.HasOne(d => d.InventoryNumberNavigation)
                    .WithMany(p => p.Services)
                    .HasForeignKey(d => d.InventoryNumber)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("service_inventory_number_fkey");
            });

            modelBuilder.Entity<Shift>(entity =>
            {
                entity.ToTable("shift");

                entity.Property(e => e.ShiftId).HasColumnName("shift_id");

                entity.Property(e => e.ShiftEnd).HasColumnName("shift_end");

                entity.Property(e => e.ShiftStart).HasColumnName("shift_start");
            });

            modelBuilder.Entity<ShiftStaff>(entity =>
            {
                entity.HasKey(e => new { e.ShiftId, e.StaffId })
                    .HasName("shift_staff_pkey");

                entity.ToTable("shift_staff");

                entity.HasIndex(e => e.StaffId, "ix_shift_staff_staff_id");

                entity.Property(e => e.ShiftId).HasColumnName("shift_id");

                entity.Property(e => e.StaffId).HasColumnName("staff_id");

                entity.HasOne(d => d.Shift)
                    .WithMany(p => p.ShiftStaffs)
                    .HasForeignKey(d => d.ShiftId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shift_staff_shift_id_fkey");

                entity.HasOne(d => d.Staff)
                    .WithMany(p => p.ShiftStaffs)
                    .HasForeignKey(d => d.StaffId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shift_staff_staff_id_fkey");
            });

            modelBuilder.Entity<StaffInventory>(entity =>
            {
                entity.HasKey(e => new { e.StaffId, e.InventoryNumber })
                    .HasName("staff_inventory_pkey");

                entity.ToTable("staff_inventory");

                entity.HasIndex(e => new { e.InventoryNumber, e.StaffId }, "staff_inventory_inventory_number_staff_id_key")
                    .IsUnique();

                entity.Property(e => e.StaffId).HasColumnName("staff_id");

                entity.Property(e => e.InventoryNumber)
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.HasOne(d => d.InventoryNumberNavigation)
                    .WithMany(p => p.StaffInventories)
                    .HasForeignKey(d => d.InventoryNumber)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("staff_inventory_inventory_number_fkey");

                entity.HasOne(d => d.Staff)
                    .WithMany(p => p.StaffInventories)
                    .HasForeignKey(d => d.StaffId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("staff_inventory_staff_id_fkey");
            });

            modelBuilder.Entity<StaffInventory2nf>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("staff_inventory_2nf");

                entity.Property(e => e.InventoryNumber)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("inventory_number");

                entity.Property(e => e.StaffId).HasColumnName("staff_id");

                entity.Property(e => e.StaffReportsTo).HasColumnName("staff_reports_to");

                entity.HasOne(d => d.InventoryNumberNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.InventoryNumber)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("staff_inventory_2nf_inventory_number_fkey");

                entity.HasOne(d => d.Staff)
                    .WithMany()
                    .HasForeignKey(d => d.StaffId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("staff_inventory_2nf_staff_id_fkey");

                entity.HasOne(d => d.StaffReportsToNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.StaffReportsTo)
                    .HasConstraintName("staff_inventory_2nf_staff_reports_to_fkey");
            });

            modelBuilder.Entity<Staff>(entity =>
            {
                entity.Property(e => e.StaffId).HasColumnName("staff_id");

                entity.ToTable("staff");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("name");

                entity.Property(e => e.ReportsTo).HasColumnName("reports_to");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("title");

                entity.HasOne(d => d.ReportsToNavigation)
                    .WithMany(p => p.InverseReportsToNavigation)
                    .HasForeignKey(d => d.ReportsTo)
                    .HasConstraintName("fk_reports_to_staff");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
