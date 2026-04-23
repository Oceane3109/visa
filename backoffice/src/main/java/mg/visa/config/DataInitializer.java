package mg.visa.config;

import mg.visa.model.TypeVisa;
import mg.visa.repository.TypeVisaRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    private final TypeVisaRepository typeVisaRepository;

    public DataInitializer(TypeVisaRepository typeVisaRepository) {
        this.typeVisaRepository = typeVisaRepository;
    }

    @Override
    public void run(String... args) {
        if (typeVisaRepository.count() == 0) {
            typeVisaRepository.save(new TypeVisa("INV", "Investisseur", "Visa pour les investisseurs étrangers"));
            typeVisaRepository.save(new TypeVisa("TRV", "Travailleur", "Visa pour les travailleurs salariés"));
            typeVisaRepository.save(new TypeVisa("ETU", "Étudiant", "Visa pour les étudiants"));
            typeVisaRepository.save(new TypeVisa("FAM", "Regroupement familial", "Visa pour regroupement familial"));
            typeVisaRepository.save(new TypeVisa("RET", "Retraité", "Visa pour les retraités"));
            typeVisaRepository.save(new TypeVisa("MIS", "Missionnaire", "Visa pour mission religieuse ou humanitaire"));
            typeVisaRepository.save(new TypeVisa("COM", "Commerçant", "Visa pour activité commerciale"));
        }
    }
}
