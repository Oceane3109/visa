package mg.visa.front.controller;

import mg.framework.annotations.Controlleur;
import mg.framework.annotations.GetMapping;
import mg.framework.model.ModelView;

@Controlleur
public class AccueilController {

    @GetMapping("/")
    public ModelView index() {
        return new ModelView("/WEB-INF/jsp/index.jsp");
    }
}
