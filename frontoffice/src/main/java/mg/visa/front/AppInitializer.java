package mg.visa.front;

import mg.framework.registry.ControllerRegistry;
import mg.framework.scan.ClasspathScanner;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ControllerRegistry registry = new ControllerRegistry();
        ClasspathScanner.scanAndRegister("mg.visa.front", registry);
        sce.getServletContext().setAttribute("mg.framework.registry", registry);

        registry.getExactRoutesSnapshot().forEach((path, methods) -> {
            System.out.println("Route: " + path);
            methods.forEach((method, handlers) -> {
                System.out.println("  " + method + ": " + handlers);
            });
        });
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}
