package smalldomains.domainmanager.validationConstraints;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented
@Constraint(validatedBy = DomainValidator.class)
@Target({ FIELD })
@Retention(RUNTIME)
public @interface ValidDomain {
    String message() default "A valid URL must be used";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
