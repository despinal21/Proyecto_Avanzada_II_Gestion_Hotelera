package gestionhotelera;

public class GestionHotelera {

    public static void main(String[] args) {
        // Mostrar la ventana de login al iniciar el programa
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Login().setVisible(true);
            }
        });
    }
}
